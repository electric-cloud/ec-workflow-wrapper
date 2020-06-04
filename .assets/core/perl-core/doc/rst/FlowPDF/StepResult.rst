NAME
====

FlowPDF::StepResult

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class sets various output results of step run in pipeline of
procedure context.

METHODS
=======

setJobStepOutcome($jobStepOutcome)
----------------------------------

.. _description-1:

Description
~~~~~~~~~~~

Schedules setting of a job step outcome. Could be warning, success or an
error.

Parameters
~~~~~~~~~~

-  (Required)(String) desired procedure/task outcome. Could be one of:
   warning, success, error.

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

Usage
~~~~~

.. code:: perl


       $stepResult->setJobStepOutcome('warning');

setPipelineSummary($pipelineSummaryName, $pipelineSummaryText)
--------------------------------------------------------------

.. _description-2:

Description
~~~~~~~~~~~

Sets the summary of the current pipeline task.

Summaries of pipelien tasks are available on pipeline stage execution
result under the "Summary" link.

Following code will set pipeline summary with name 'Procedure Exectuion
Result:' to 'All tests are ok'

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (Required)(String) Pipeline Summary Property Text
-  (Required)(String) Pipeline Summary Value.

.. _returns-1:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. _usage-1:

Usage
~~~~~

.. code:: perl


       $stepResult->setPipelineSummary('Procedure Execution Result:', 'All tests are ok');

setJobStepSummary($jobStepSummary)
----------------------------------

.. _description-3:

Description
~~~~~~~~~~~

Sets the summary of the current **job step**.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Required)(String) Job Step Summary

.. _returns-2:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. _usage-2:

Usage
~~~~~

.. code:: perl


       $stepResult->setJobStepSummary('All tests are ok in this step.');

setJobSummary($jobSummary)
--------------------------

.. _description-4:

Description
~~~~~~~~~~~

Sets the summary of the current **job**.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (Requried)(String) Job Summary

.. _returns-3:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. _usage-3:

Usage
~~~~~

.. code:: perl


       $stepResult->setJobSummary('All tests are ok');

setOutcomeProperty($propertyPath, $propertyValue)
-------------------------------------------------

.. _description-5:

Description
~~~~~~~~~~~

Sets the outcome property.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  (Required)(String) Property Path
-  (Required)(String) Value of property to be set

.. _returns-4:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. code:: perl


       $stepResult->setOutcomeProperty('/myJob/buildNumber', '42');

setOutputParameter($parameterName, $parameterValue)
---------------------------------------------------

.. _description-6:

Description
~~~~~~~~~~~

Sets an output parameter for a job.

.. _parameters-5:

Parameters
~~~~~~~~~~

-  (Required)(String) Output parameter name
-  (Required)(String) Output parameter value

.. _returns-5:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. code:: perl


       $stepResult->setOutputParameter('Last Build Number', '42');

setReportUrl($reportName, $reportUrl)
-------------------------------------

.. _description-7:

Description
~~~~~~~~~~~

Sets a report and it's URL for the job. If it is being invoked in
pipeline runs, sets also a property with a link to the pipeline summary.

.. _parameters-6:

Parameters
~~~~~~~~~~

-  (Required)(String) Report name
-  (Required)(String) Report URL

.. _returns-6:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. code:: perl


       $stepResult->setReportUrl('Build Link #42', 'http://localhost:8080/job/HelloWorld/42');

apply()
-------

.. _description-8:

Description
~~~~~~~~~~~

Applies scheduled changes without schedule cleanup in queue order: first
scheduled, first executed.

.. _parameters-7:

Parameters
~~~~~~~~~~

-  None

.. _returns-7:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. code:: perl


       $stepResult->apply();

flush()
-------

.. _description-9:

Description
~~~~~~~~~~~

Flushes scheduled actions.

.. _parameters-8:

Parameters
~~~~~~~~~~

-  None

.. _returns-8:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. _usage-4:

Usage
~~~~~

.. code:: perl


       $stepResult->flush();

applyAndFlush
-------------

.. _description-10:

Description
~~~~~~~~~~~

Executes the schedule queue and flushes it then.

.. _parameters-9:

Parameters
~~~~~~~~~~

-  None

.. _returns-9:

Returns
~~~~~~~

-  (FlowPDF::StepResult) self

.. _usage-5:

Usage
~~~~~

.. code:: perl


       $stepResult->applyAndFlush();


