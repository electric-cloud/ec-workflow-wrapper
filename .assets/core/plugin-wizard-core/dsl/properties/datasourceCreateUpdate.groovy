/**
 * Expected input arguments to the script:
 * releaseName: Name of the ElectricFlow release
 * projectName: The name of the ElectricFlow project that the release belongs to.
 * reportObjectTypeName: The name of the report object type, e.g, 'feature', 'build'.
 * scheduleName: The name of the schedule and procedure if the plugin needs to create them.
 * scheduleProjectName: The name of the project that the schedule belongs to.
 * pluginParameters: Map of parameter name-value pairs for the plugin parameters defined in the form XML.
 */


import com.electriccloud.domain.DevOpsInsightDataSourceResult
import com.electriccloud.errors.EcException
import com.electriccloud.errors.ErrorCodes

// Plugins metadata
def pluginName = '{{pluginName}}'

String getSourceDetails(Map pluginParameters) {
    def sourceIdentifier = pluginParameters.projectKey

    if (pluginParameters.planKey) {
        sourceIdentifier += '-' + pluginParameters.planKey
    }

    return sourceIdentifier
}

void validatePluginParams(Map pluginParameters) {
    if (pluginParameters == null) {
        throw EcException
                .code(ErrorCodes.InvalidParameterValue)
                .message("pluginParameters are required for dsl script")
                .build();
    }

    checkRequiredParameters(pluginParameters)

    // Specific checks can be placed below this line
    String frequency = pluginParameters.frequency

    if (!((frequency ?: "").isInteger()) || Integer.parseInt(frequency) <= 0) {
        throw EcException.code(ErrorCodes.InvalidArgument)
                .message("'Polling Frequency' must be a positive integer.")
                .build();
    }

}

def getCreateActualParameters(Map pluginParameters) {
    return [
            config               : pluginParameters.configName,
            {% for parameter in parameters %}
            {{parameter.name}} : pluginParameters.{{parameterName}},
            {% endfor %}
            previewMode: '0',
            debug: '0'
    ]
}


def getModifyActualParameters(Map pluginParameters) {
    return [
            config               : pluginParameters.configName,
            {% for parameter in parameters %}
            {{parameter.name}} : pluginParameters.{{parameterName}},
            {% endfor %}
    ]
}

// === datasource starts ====
// === datasource template ===

void checkPayloadType(String payloadType) {
    if (payloadType == null) {
        throw EcException
                .code(ErrorCodes.InvalidParameterValue)
                .message("payloadType is required for dsl script")
                .build();
    }

    def supportedTypes = [
        {% for payloadType in types %}
        '{{payloadType}}',
        {% endfor %}
    ]
    if (supportedTypes.indexOf(payloadType) < 0) {
        throw EcException
                .code(ErrorCodes.InvalidParameterValue)
                .message("Payload type '$payloadType' is not supported")
                .build();
    }
}

void checkRequiredParameters(Map pluginParameters) {
    def params = ['config']
    // todo
    params.each { it ->
        if (pluginParameters[it] == null) {
            throw EcException
                    .code(ErrorCodes.MissingArgument)
                    .message("plugin parameter $it is required for dsl script")
                    .build();
        }
    }

}

String getConfigProperty(Map pluginParameters) {
    String configName = pluginParameters.config
    return "/plugins/{{pluginName}}/project/ec_plugin_cfgs/${configName}/"
}

if (args.releaseName == null) {
    throw EcException
            .code(ErrorCodes.MissingArgument)
            .message("releaseName is required for dsl script")
            .build();
}
if (args.projectName == null) {
    throw EcException
            .code(ErrorCodes.MissingArgument)
            .message("projectName is required for dsl script")
            .build();
}
if (args.reportObjectTypeName == null) {
    throw EcException
            .code(ErrorCodes.MissingArgument)
            .message("reportObjectTypeName is required for dsl script")
            .build();
}
if (args.scheduleName == null) {
    throw EcException
            .code(ErrorCodes.MissingArgument)
            .message("scheduleName is required for dsl script")
            .build();
}
if (args.scheduleProjectName == null) {
    throw EcException
            .code(ErrorCodes.MissingArgument)
            .message("scheduleProjectName is required for dsl script")
            .build();
}


def releaseName = args.releaseName;
def projectName = args.projectName;
def scheduleName = args.scheduleName;
def scheduleProjectName = args.scheduleProjectName;

def procedureExists(String prjct, String prcdr) {
    def projects = getProjects();

    def proj = projects.grep({ it.projectName == prjct });
    if (!proj.size()) {
        return false
    }

    def procedures = getProcedures(projectName: prjct);

    def proc = false;
    procedures.each {
        if (it.procedureName == prcdr) {
            proc = true;
        }
    }

    if (!proc) {
        return false;
    }

    return true;
}

{% if action == 'create' %}
if (procedureExists(scheduleProjectName, scheduleName)) {
    throw EcException
            .code(ErrorCodes.ScriptError)
            .message("Procedure '${scheduleName}' already exists in project '${scheduleProjectName}' and can not be modified")
            .build();
}
{% else %}
if (!procedureExists(scheduleProjectName, scheduleName)) {
    throw EcException
            .code(ErrorCodes.ScriptError)
            .message("Procedure '${scheduleName}' already exists in project '${scheduleProjectName}' and can not be modified")
            .build();
}
{% endif %}

// Plugin form params
def pluginParameters = args.pluginParameters;
// After this line code will be plugin-specific.


validatePluginParams(args.pluginParameters)
checkPayloadType(args.reportObjectTypeName)

// Extract the parameters expected through the form XML
// EC-Bamboo param:
// configName
// projectKey
// planKey
// frequency

{% if action == 'create' %}
def actualParameters = getCreateActualParameters(pluginParameters)
{% else %}
def actualParameters = getModifyActualParameters(pluginParameters)
{% endif %}

project scheduleProjectName, {
    resourceName = null
    workspaceName = null

    procedure scheduleName, {
        description = ''
        jobNameTemplate = ''
        resourceName = ''
        timeLimit = ''
        timeLimitUnits = 'minutes'
        workspaceName = ''

        step 'collect', {
            description = ''
            alwaysRun = '0'
            broadcast = '0'
            command = null
            condition = ''
            errorHandling = 'failProcedure'
            exclusiveMode = 'none'
            logFileName = null
            parallel = '0'
            postProcessor = null
            precondition = ''
            releaseMode = 'none'
            resourceName = ''
            shell = null
            subprocedure = 'CollectReportingData'
            subproject = "/plugins/${pluginName}/project"
            timeLimit = ''
            timeLimitUnits = 'minutes'
            workingDirectory = null
            workspaceName = ''
            actualParameters.each { k, v ->
                actualParameter k, v
            }
            actualParameter 'releaseName', releaseName
            actualParameter 'releaseProjectName', scheduleProjectName
        }
    }

    schedule scheduleName, {
        description = ''
        applicationName = null
        applicationProjectName = null
        beginDate = ''
        endDate = ''
        environmentName = null
        environmentProjectName = null
        environmentTemplateName = null
        environmentTemplateProjectName = null
        environmentTemplateTierMapName = null
        interval = pluginParameters.frequency
        intervalUnits = 'minutes'
        misfirePolicy = 'ignore'
        monthDays = ''
        pipelineName = null
        priority = 'normal'
        procedureName = scheduleName
        processName = null
        releaseName = null
        rollingDeployEnabled = null
        rollingDeployManualStepAssignees = null
        rollingDeployManualStepCondition = null
        rollingDeployPhases = null
        scheduleDisabled = '0'
        snapshotName = null
        startTime = ''
        startingStage = null
        startingStateName = null
        stopTime = ''
        timeZone = ''
        weekDays = ''
        workflowName = null
    }
}

def configLocation = getConfigProperty(pluginParameters)
def sourceDetails = getSourceDetails(pluginParameters)

def retval = new DevOpsInsightDataSourceResult();

retval.connectionInfo = getProperty(configLocation, suppressNoSuchPropertyException: true)?.value;
retval.sourceDetails = sourceDetails;
retval.scheduleName = scheduleName;
retval.scheduleProjectName = scheduleProjectName;

retval;

// === datasource template ends ===
// === datasource ends ===

