// This procedure.dsl was generated automatically
// === procedure_autogen starts ===
// === procedure_autogen template ===
{%- import _self as this -%}
{%- macro recursiveProperty (property) %}
property '{{ property.name }}', {% if property.credentialProtected %}credentialProtected: "1", {% endif %}{
{% if property.description %}description = '''{{property.description}}'''{% endif %}
    {% if property.expandable %}{% else %}expandable = false{% endif %}
{% if property.value %}
    {% if property.value.path %}
        value = new File(pluginDir, "{{property.value.path}}").text
    {% else %}
        value = '''{{ property.value.value }}'''
    {% endif %}
{% else %}
    {% if property.ecProperties.size() %}
    {% for p in property.ecProperties %}
        {% import _self as recursive %}
        {{ recursive.recursiveProperty(p)}}
    {% endfor %}
    {% endif %}
{% endif %}
}
{% endmacro -%}

procedure '{{procedure.name}}', description: '''{{procedure.description}}''', {
    {% if procedure.hideFromStepPicker %}property 'standardStepPicker', value: false{% endif %}
{% for step in procedure.steps %}
    {% if procedure.resourceName %}resourceName = '{{procedure.resourceName}}'{% endif %}
    {% if procedure.workspaceName %}workspaceName = '{{procedure.workspaceName}}'{% endif %}
    {% if procedure.jobNameTemplate %}jobNameTemplate = '{{procedure.jobNameTemplate}}'{% endif %}
    {% if procedure.prependSetupStep %}
    // Handling binary dependencies
    step 'flowpdk-setup', {
        description = "This step handles binary dependencies delivery"
        subprocedure = 'flowpdk-setup'
        actualParameter = [
            generateClasspathFromFolders: '{{generateClasspathFromFolders}}'
        ]
    }
    {% endif %}
    step '{{ step.name }}', {
        description = '{{ step.description }}'
        {% if step.shell %}command = new File(pluginDir, "dsl/procedures/{{ procedure.procedureFolderName }}/steps/{{ step.stepFileName() }}").text{% endif %}
        {% if step.shell %}shell = '{{ step.shell }}'{% endif %}
        {% if step.processedShell %}shell = '{{step.processedShell}}'{% endif %}
        {% for paramKey in step.additionalParameters.keySet() %}
            {% if (paramKey) %}{{paramKey}} = '''{{ step.additionalParameters.get(paramKey) }}'''{% endif %}
        {% endfor %}

        {%- if step.ecProperties %}
            // step properties
            {%- for p in step.ecProperties %}
            {{this.recursiveProperty(p)}}
            {% endfor -%}
        {% endif -%}

        {%- if step.actualParameters %}
        actualParameter = [
            {%- for key, value in step.actualParameters %}
            '{{key}}' : '''{{value}}''',
            {% endfor -%}
        ]
        {% endif -%}
        {% if procedure.prependSetupStep %}
        resourceName = '$[/myJobStep/parent/steps/flowpdk-setup/flowpdkResource]'
        {% endif %}
        postProcessor = '''$[/myProject/perl/postpLoader]'''
    }

{% endfor %}
{% for outputParameter in procedure.outputParameters %}
    formalOutputParameter '{{ outputParameter.name }}',
        description: '{{ outputParameter.description }}'
{% endfor %}

{%- if procedure.ecProperties %}
// procedure properties
{%- for p in procedure.ecProperties %}
{{this.recursiveProperty(p)}}
{% endfor -%}
{% endif -%}

// === procedure_autogen template ends===
// === procedure_autogen ends ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}
