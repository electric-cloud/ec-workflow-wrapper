OVERVIEW:

The "WorkflowWrapper" ElectricCommander/ElectricFlow plugin provides a procedure that launches and monitors a workflow.

USAGE:

You must first install and promote the plugin (available in out/WorkflowWrapper.jar).  When you are creating a schedule or continuous integration trigger to launch a workflow, select the WorkflowWrapper plugin as the project and WorkflowWrapper as the procedure.  You are prompted for the following parameters:
- definition_name: Name of the workflow definition being launched.
- definition_parameters: Parameters to starting state specified in the format passed to an ec-perl runWorkflow call. Required parameters to the starting state must be specified or the workflow won't be launched. For example:
```
    {actualParameterName => "branch", value => "main"},
    {actualParameterName => "revision", value => 12345},
```
- definition_project_name: Name of the project containing the workflow definition being launched.
- definition_starting_state: Name of the starting state for the workflow definition being launched.
- job_name: Name of the wrapper job; defaults to `workflow_wrapper_$[jobId]_$[/timestamp]` if unspecified.

Once your schedule or CI trigger fires, it creates a job that does the following:
- Launches the workflow by calling the runWorkflow API.
- Stores a link called "Workflow" on the job details page to the workflow and another link called "Wrapper" on the workflow details page back to the job.
- Monitors the workflow by polling until the workflow is complete (a workflow is complete when it is manually stopped/completed or when it reaches a state with no outbound transitions).  As it polls, information about the workflow is stored on the wrapper job:
  - The step walks through the workflow, all its states and transitions and subjobs, and then recursively through any subworkflows.  It stores information about all workflows and jobs in a hierarchical JSON data structure stored in a property called "workflow_details" on the wrapper job.  This is very useful if you need to process the full workflow hierarchy since all the information is available in one property.
  - The active state of the workflow is stored in a property called "workflow_active_state" on the wrapper job.
  - A special property called "compositeJobOutcome" is created in the "workflow_details" JSON, set to error if any job within the workflow hierarchy has failed, warning if any job has a warning, or success if all jobs are successful.  The outcome of the "Monitor" step and the wrapper job is set to the composite job outcome so you can easily tell if there's an error/warning.
  - When the workflow is complete, a special property called "completedAutomatically" is created in the "workflow_details" JSON.  The property is set to 1 if the workflow was completed by virtue of ending up in a state with no possible outbound transitions, or 0 if the workflow was manually completed.
- The monitoring step also manages some information that is displayed by the CI dashboard; this is useful when the wrapper is called via a CI trigger.
  - A wrapper job property called "ec_job_description" is created to see basic information about the workflow.  The dashboard displays the HTML in this property when mousing over the wrapper job.
  - A wrapper job property called "ec_job_progress_status" stores the workflow's active state.  The dashboard displays the value of this property under the progress bar for the wrapper job.  

SOURCES:

The sources are available in the src directory. They were built using the Commander SDK v2.0. The documentation for the SDK is available at http://docs.electric-cloud.com.

AUTHOR:

Tanay Nagjee, Electric Cloud Solutions Engineer
tanay@electric-cloud.com

DISCLAIMER:

This module is not officially supported by Electric Cloud.