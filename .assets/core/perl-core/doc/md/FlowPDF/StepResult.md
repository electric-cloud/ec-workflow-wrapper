# NAME

FlowPDF::StepResult

# AUTHOR

CloudBees

# DESCRIPTION

This class sets various output results of step run in pipeline of procedure context.

# METHODS

## setJobStepOutcome($jobStepOutcome)

### Description

Schedules setting of a job step outcome. Could be warning, success or an error.

### Parameters

- (Required)(String) desired procedure/task outcome. Could be one of: warning, success, error.

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->setJobStepOutcome('warning');

```

## setPipelineSummary($pipelineSummaryName, $pipelineSummaryText)

### Description

Sets the summary of the current pipeline task.

Summaries of pipelien tasks are available on pipeline stage execution result under the "Summary" link.

Following code will set pipeline summary with name 'Procedure Exectuion Result:' to 'All tests are ok'

### Parameters

- (Required)(String) Pipeline Summary Property Text
- (Required)(String) Pipeline Summary Value.

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->setPipelineSummary('Procedure Execution Result:', 'All tests are ok');

```

## setJobStepSummary($jobStepSummary)

### Description

Sets the summary of the current **job step**.

### Parameters

- (Required)(String) Job Step Summary

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->setJobStepSummary('All tests are ok in this step.');

```

## setJobSummary($jobSummary)

### Description

Sets the summary of the current **job**.

### Parameters

- (Requried)(String) Job Summary

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->setJobSummary('All tests are ok');

```

## setOutcomeProperty($propertyPath, $propertyValue)

### Description

Sets the outcome property.

### Parameters

- (Required)(String) Property Path
- (Required)(String) Value of property to be set

### Returns

- (FlowPDF::StepResult) self

```perl

    $stepResult->setOutcomeProperty('/myJob/buildNumber', '42');

```

## setOutputParameter($parameterName, $parameterValue)

### Description

Sets an output parameter for a job.

### Parameters

- (Required)(String) Output parameter name
- (Required)(String) Output parameter value

### Returns

- (FlowPDF::StepResult) self

```perl

    $stepResult->setOutputParameter('Last Build Number', '42');

```

## setReportUrl($reportName, $reportUrl)

### Description

Sets a report and it's URL for the job.
If it is being invoked in pipeline runs, sets also a property with a link to the pipeline summary.

### Parameters

- (Required)(String) Report name
- (Required)(String) Report URL

### Returns

- (FlowPDF::StepResult) self

```perl

    $stepResult->setReportUrl('Build Link #42', 'http://localhost:8080/job/HelloWorld/42');

```

## apply()

### Description

Applies scheduled changes without schedule cleanup in queue order: first scheduled, first executed.

### Parameters

- None

### Returns

- (FlowPDF::StepResult) self

```perl

    $stepResult->apply();

```

## flush()

### Description

Flushes scheduled actions.

### Parameters

- None

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->flush();

```

## applyAndFlush

### Description

Executes the schedule queue and flushes it then.

### Parameters

- None

### Returns

- (FlowPDF::StepResult) self

### Usage

```perl

    $stepResult->applyAndFlush();

```