use strict;
use warnings;
use ElectricCommander;

my $ec = new ElectricCommander;

sub getPropertyValue($);

my $project = getPropertyValue("/myParent/definition_project_name");
my $workflow = getPropertyValue("/myParent/definition_name");
my $start = getPropertyValue("/myParent/definition_starting_state");
my $parameters_raw = getPropertyValue("/myParent/definition_parameters");
my $parameters = eval('[' . $parameters_raw . ']');

$ec->setProperty("/myJob/ec_job_progress_status", "Launching workflow...");

my $result = $ec->runWorkflow({
    projectName => $project,
    workflowDefinitionName => $workflow,
    startingState => $start,
    actualParameter => $parameters
});
my $name = $result->findvalue("//workflowName")->value();
my $link = "/commander/link/workflowDetails/projects/$project/workflows/$name";
$ec->setProperty("/myParent/workflow_name", $name);
$ec->setProperty("/myJob/report-urls/Workflow", $link);
$ec->setProperty(
    "/projects/$project/workflows/$name/report-urls/Wrapper",
    "/commander/link/jobDetails/jobs/$[jobId]");
$ec->setProperty("/myJob/ec_job_description",
    "<html><div style='padding:5px'><a target='_blank' href='$link'>View workflow</a></div></html>");

# Helper method to extract the value of a property.

sub getPropertyValue($)
{
    my ($name) = @_;
    return $ec->getProperty($name)->findvalue("//value")->value();
}
