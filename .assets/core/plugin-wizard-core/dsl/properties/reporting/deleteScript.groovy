/**
 * Expected input arguments to the script:
 * releaseName: Name of the ElectricFlow release
 * projectName: The name of the ElectricFlow project that the release belongs to.
 * reportObjectTypeName: The name of the report object type, e.g, 'feature', 'build'.
 * scheduleName: The name of the schedule and procedure if the plugin needs to create them.
 * scheduleProjectName: The name of the project that the schedule belongs to.
 * pluginParameters: Map of parameter name-value pairs for the plugin parameters defined in the form XML.
 */

import com.electriccloud.errors.EcException;
import com.electriccloud.errors.ErrorCodes;

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


args.scheduleName.trim()
args.scheduleProjectName.trim()

def scheduleName         = args.scheduleName;
def scheduleProjectName  = args.scheduleProjectName;


deleteProcedure(scheduleProjectName, scheduleName);
deleteSchedule(scheduleProjectName, scheduleName);

return true;
