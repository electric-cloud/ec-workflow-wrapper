package FlowPlugin::ecworkflowwrapper;
use strict;
use warnings;
use base qw/FlowPDF/;
use FlowPDF::Log;

use ElectricCommander;
my $ec = new ElectricCommander;

# Feel free to use new libraries here, e.g. use File::Temp;

# Service function that is being used to set some metadata for a plugin.
sub pluginInfo {
    return {
        pluginName          => '@PLUGIN_KEY@',
        pluginVersion       => '@PLUGIN_VERSION@',
        configFields        => ['config'],
        configLocations     => ['ec_plugin_cfgs'],
        defaultConfigValues => {}
    };
}

# Auto-generated method for the procedure WorkflowWrapper/Launch
# Add your code into this method and it will be called when step runs
# $self - reference to the plugin object
# $p - step parameters
# $sr - StepResult object
sub launch {
    my ($self, $p, $sr) = @_;

    my $context = $self->getContext();
    logInfo("Current context is: ", $context->getRunContext());
    logInfo("Step parameters are: ", $p);

	sub getPropertyValue($);

	my $project = getPropertyValue("/myParent/definition_project_name");
	my $workflow = getPropertyValue("/myParent/definition_name");
	my $start = getPropertyValue("/myParent/definition_starting_state");
	my $parameters_raw = getPropertyValue("/myParent/definition_parameters");
	my $parameters = eval('[' . $parameters_raw . ']');

	$ec->setProperty("/myJob/ec_job_progress_status", "Launching pipeline...");

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
		"<html><div style='padding:5px'><a target='_blank' href='$link'>View pipeline</a></div></html>");

    $sr->setJobStepOutcome('warning');
    $sr->setJobSummary("This is a job summary.");
}
# Auto-generated method for the procedure WorkflowWrapper/Monitor
# Add your code into this method and it will be called when step runs
# $self - reference to the plugin object
# $p - step parameters
# $sr - StepResult object
sub monitor {
    my ($self, $p, $sr) = @_;

    my $context = $self->getContext();
    logInfo("Current context is: ", $context->getRunContext());
    logInfo("Step parameters are: ", $p);

	use ElectricCommander;
	use JSON;

	my $ec = new ElectricCommander;

	sub getPropertyValue($);
	sub expandWorkflow($$);

	my $project = getPropertyValue('/myParent/definition_project_name');
	my $workflow = getPropertyValue('/myParent/workflow_name');

	my $interval = 5;
	my $completed = 0;
	my $lastDetails = "";
	my $lastOutcome = "";
	my $lastActiveState = "";
	my $expanded;

	do {
		my $json = JSON->new->allow_nonref;
		$expanded = expandWorkflow($project, $workflow);
		my $details = $json->pretty->canonical->encode($expanded);

		# Only bother setting the details property if it's changed.
		if ($details ne $lastDetails) {
			$ec->setProperty("/myParent/workflow_details", $details);
			$lastDetails = $details;
		}

		# Only bother setting the outcome property if the compositeJobOutcome has changed.
		if ($lastOutcome ne $expanded->{"compositeJobOutcome"}) {
			$ec->setProperty("outcome", $expanded->{"compositeJobOutcome"});
			$lastOutcome = $expanded->{"compositeJobOutcome"};
		}

		# Only bother setting the active state property if it's changed.
		if ($lastActiveState ne $expanded->{"activeState"}) {
			$ec->setProperty("/myParent/workflow_active_state", $expanded->{"activeState"});
			$lastActiveState = $expanded->{"activeState"};
			$ec->setProperty("/myJob/ec_job_progress_status", $expanded->{"activeState"});
		}

		$completed = $expanded->{"completed"};

		# If we're monitoring the workflow, keep sleeping for the specified interval
		# until we the workflow is completed.
		if (!$completed) {
			sleep $interval;
		}
	} while (!$completed);

	my $finalState = $expanded->{"activeState"};
	if ($finalState eq "Fail"
		|| $finalState eq "Failed"
		|| $finalState eq "Error"
		|| $finalState eq "Rejected") {
		print "The workflow is considered to hvae failed because it ended in $finalState\n";
		exit 1;
	}

    $sr->setJobStepOutcome('warning');
    $sr->setJobSummary("This is a job summary.");
}
## === step ends ===
# Please do not remove the marker above, it is used to place new procedures into this file.

# Helper method to extract the value of a property.
sub getPropertyValue($)
{
	
    my ($name) = @_;
    return $ec->getProperty($name)->findvalue("//value")->value();
}

# Main helper method to expand a workflow and return the JSON representing the
# workflow, its states and transitions, and its subworkflows and subjobs.  Called
# recursively to fetch subworkflow information.

sub expandWorkflow($$)
{
    my ($project, $workflow) = @_;

    # Fields from the "get" server responses that are safe to ignore.
    my %exclude = (
        "actualParameters", 1,
        "combinedStatus", 1,
        "createTime", 1,
        "description", 1,
        "lastModifiedBy", 1,
        "modifyTime", 1,
        "owner", 1,
        "propertySheetId", 1,
        "workspace", 1
    );

    my %workflowData;

    # Save all the workflow's metadata.
    my $result = $ec->getWorkflow($project, $workflow);
    foreach my $workflowElement($result->findnodes("/responses/response/workflow/*")) {
        my $name = $workflowElement->getName();
        my $value = $workflowElement->string_value;
        if (!defined($exclude{$name}) && $value ne "") {
            $workflowData{$name} = $value;
        }
    }

    # Save the "compositeJobOutcome" of the workflow, which is composed using the outcomes
    # of all subjobs/subworkflows.
    my $compositeJobOutcome = "success";

    # Save information for each of the workflow's states.
    my @statesData = ();
    my $stateIndex = 0;
    $result = $ec->getStates($project, $workflow);
    foreach my $state($result->findnodes("/responses/response/state")) {
        my %stateData;
        my $stateName = $state->findvalue("stateName")->string_value;

        # Save all the state's metadata, and expand subjob/subworkflow elements
        # if they exist.
        foreach my $stateElement($state->findnodes("*")) {
            my $name = $stateElement->getName();
            my $value = $stateElement->string_value;
            if (!defined($exclude{$name}) && $value ne "") {
                $stateData{$name} = $value;
                my $subprocessOutcome = "";

                if ($name eq "subworkflow") {
                    # Account for different formats for the <subworkflow> element.  In
                    # either case, call expandWorkflow recursively on the subworkflow.
                    if ($value =~ m#/projects/(.*)/workflows/(.*)#) {
                        $stateData{"subworkflowDetail"} = expandWorkflow($1, $2);
                    } else {
                        $stateData{"subworkflowDetail"} = expandWorkflow($project, $value);
                    }
                    $subprocessOutcome = $stateData{"subworkflowDetail"}
                        {"compositeJobOutcome"};
                } elsif ($name eq "subjob") {
                    # Use the "getJobInfo" API call and save the job information.
                    my %jobData;
                    my $jobInfo = $ec->getJobInfo($value);
                    foreach my $jobElement($jobInfo->findnodes("/responses/response/job/*")) {
                        my $name = $jobElement->getName();
                        my $value = $jobElement->string_value;
                        if (!defined($exclude{$name}) && $value ne "") {
                            $jobData{$name} = $value;
                        }
                    }
                    $stateData{"subjobDetail"} = \%jobData;
                    $subprocessOutcome = $jobInfo->findvalue("//outcome")->string_value;
                }
                if ($subprocessOutcome ne "" && $compositeJobOutcome ne "error") {
                    if ($compositeJobOutcome eq "success"
                        && $subprocessOutcome ne "success") {
                        $compositeJobOutcome = $subprocessOutcome;
                    } elsif ($compositeJobOutcome eq "warning"
                        && $subprocessOutcome eq "error") {
                        $compositeJobOutcome = $subprocessOutcome;
                    }
                }
            }
        }

        # Save information for each of the state's transitions.
        my @transitionsData = ();
        my $transitionIndex = 0;
        $result = $ec->getTransitions($project, $workflow, $stateName);
        foreach my $transition($result->findnodes("/responses/response/transition")) {
            my %transitionData;
            my $transitionName = $transition->findvalue("transitionName")->string_value;
            foreach my $transitionElement($transition->findnodes("*")) {
                my $name = $transitionElement->getName();
                my $value = $transitionElement->string_value;
                if (!defined($exclude{$name}) && $value ne "") {
                    $transitionData{$name} = $value;
                }
            }
            $transitionsData[$transitionIndex] = \%transitionData;
            $transitionIndex++;
        }
        $stateData{'transition'} = \@transitionsData;
        $statesData[$stateIndex] = \%stateData;
        $stateIndex++;
    }
    $workflowData{'compositeJobOutcome'} = $compositeJobOutcome;
    $workflowData{'state'} = \@statesData;

    # Check the last log entry to see if the workflow was automatically or manually
    # completed and save it.  If manual, also save the user who completed it.
    if ($workflowData{'completed'}) {
        my $workflowId = $workflowData{'workflowId'};
        my $result = $ec->findObjects('logEntry', {
            filter =>
            [
                {
                    propertyName => "severity",
                    operator => "equals",
                    operand1 => "INFO"
                },
                {
                    propertyName => "message",
                    operator => "contains",
                    operand1 => "has completed the workflow"
                },
                {
                    operator => "equals",
                    propertyName => "container",
                    operand1 => "workflow-$workflowId"
                }
            ],
            maxIds => 1,
            numObjects => 1
        });
        if (scalar($result->findnodes("//logEntry"))) {
            $workflowData{'completedAutomatically'} = 0;
            my $message = $result->findvalue("//message")->string_value;
            $message =~ m/User \'(.*)\' has completed the workflow/;
            $workflowData{'completedByUser'} = $1;
        } else {
            $workflowData{'completedAutomatically'} = 1;
        }
    }

    return \%workflowData;
}

1;