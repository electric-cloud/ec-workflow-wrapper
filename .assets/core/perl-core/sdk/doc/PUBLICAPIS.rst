Public APIs of FlowPDF Perl SDK
===============================

This document exposes all currently available public methods by their
classes.

FlowPDF
-------

This class is an entry point to all framework logic. This class is the
class that is being extended by the main plugin class.

-  `newContext </doc/md/FlowPDF.md#newcontext>`__ - A method that
   creates new `FlowPDF::Context </doc/md/FlowPDF/Context.md>`__ object.
-  `getContext </doc/md/FlowPDF.md#getcontext>`__ - This method returns
   previously created context object. If there is no context object, it
   is being created and returned then.
-  `getPluginProjectName </doc/md/FlowPDF.md#getpluginprojectname>`__ -
   A method that returns a complete name of your plugin with version as
   string.

FlowPDF::ComponentManager
-------------------------

This class is responsible for Components Ecosystem. Components is an
extensions to the FlowPDF. Now we have following component available:

-  `FlowPDF::Component::Proxy </doc/md/FlowPDF/Component/Proxy.md>`__
-  `FlowPDF::Component::CLI </doc/md/FlowPDF/Component/CLI.md>`__
-  `FlowPDF::Component::OAuth </doc/md/FlowPDF/Component/Oauth.md>`__

`FlowPDF::ComponentManager </doc/md/FlowPDF/ComponentManager.md>`__

-  `new </doc/md/FlowPDF/ComponentManager.md#new>`__ - Creates new
   `FlowPDF::ComponentManager </doc/md/FlowPDF/Context.md>`__ object.
-  `loadComponent </doc/md/FlowPDF/ComponentManager.md#loadcomponent>`__
   - Loads new component.
-  `loadComponentLocal </doc/md/FlowPDF/ComponentManager.md#loadcomponentlocal>`__
   - Loads new component locally.
-  `getComponent </doc/md/FlowPDF/ComponentManager.md#getcomponent>`__ -
   Gets previously loaded component.
-  `getComponentLocal </doc/md/FlowPDF/ComponentManager.md#getcomponentlocal>`__
   - Gets previously loaded local component.

FlowPDF::Config
---------------

This class represents a plugin configuration object.

`FlowPDF::Config </doc/md/FlowPDF/Config.md>`__

-  getParameter
-  getParametersList
-  getRequiredParameter

FlowPDF::Context
----------------

This class represents a context of the current runtime. Context allows
to get context-dependent parameters, set context-dependent properties,
outcomes, summaries, control execution flow of current task.

`FlowPDF::Context </doc/md/FlowPDF/Context.md>`__

-  `getRuntimeParameters </doc/md/FlowPDF/Context.md#getruntimeparameters>`__
   - Returns a hashref of all runtime parameters. Step parameters +
   config values.
-  `getStepParameters </doc/md/FlowPDF/Context.md#getstepparameters>`__
   - returns step parameters as
   `FlowPDF::StepParameters </doc/md/FlowPDF/StepParameters.md>`__
   object.
-  `getConfigValues </doc/md/FlowPDF/Context.md#getconfigvalues>`__ -
   returns configuration values as
   `FlowPDF::Config </doc/md/FlowPDF/Config.md>`__ object.
-  `newStepResult </doc/md/FlowPDF/Context.md#newstepresult>`__ -
   returns an `FlowPDF::StepResult </doc/md/FlowPDF/StepResult.md>`__
   object to set various output values during execution.
-  `newRESTClient </doc/md/FlowPDF/Context.md#newrestclient>`__ -
   returns `FlowPDF::Client::REST </doc/md/FlowPDF/Client/REST.md>`__
   object for http interaction.

FlowPDF::Credential
-------------------

A credential representation. Stores ElectricFlow credetials.

`FlowPDF::Credential </doc/md/FlowPDF/Credential.md>`__

-  `getCredentialType </doc/md/FlowPDF/Credential.md#getcredentialtype>`__
   - Returns different values for different credentials type. For
   FlowPDF SDK Drop1 only default is supported.
-  `getUserName </doc/md/FlowPDF/Credential.md#getusername>`__ - Returns
   a user name that is being stored in the current credential.
-  `getSecretValue </doc/md/FlowPDF/Credential.md#getsecretvalue>`__ -
   Returns a secret value that is being stored in the current
   credential.
-  `getCredentialName </doc/md/FlowPDF/Credential.md#getcredentialname>`__
   - Returns a name for the current credential.

FlowPDF::Log
------------

A class for logging.

`FlowPDF::Log </doc/md/FlowPDF/Log.md>`__

-  `logInfo </doc/md/FlowPDF/Log.md#loginfo>`__ - Logs an info message.
   Output is the same as from print function.
-  `logDebug </doc/md/FlowPDF/Log.md#logdebug>`__ - Logs a debug
   message:
-  `logTrace </doc/md/FlowPDF/Log.md#logtrace>`__ - Logs a trace message
-  `logWarning </doc/md/FlowPDF/Log.md#logwarning>`__ - logs a warning
   message
-  `logError </doc/md/FlowPDF/Log.md#logerror>`__ - logs an error
   message.

FlowPDF::Parameter
------------------

This class represents a regular parameter of procedure or configuration.

`FlowPDF::Parameter </doc/md/FlowPDF/Parameter.md>`__

-  `getName </doc/md/FlowPDF/Parameter.md#getname>`__ - returns a name
   for the current parameter.
-  `getValue </doc/md/FlowPDF/Parameter.md#getvalue>`__ - returns a
   value for the current parameter.
-  `setName </doc/md/FlowPDF/Parameter.md#setname>`__ - sets a name for
   the current parameter.
-  `setValue </doc/md/FlowPDF/Parameter.md#setvalue>`__ - sets a value
   for the current parameter.

FlowPDF::StepParameters
-----------------------

This class represents context-dependent parameters of current step. It
is being created through context object.

`FlowPDF::StepParameters </doc/md/FlowPDF/StepParameters.md>`__

-  `isParameterExists </doc/md/FlowPDF/StepParameters.md#isparameterexists>`__
   - Returns true if parameter exists in the current step.
-  `getParameter </doc/md/FlowPDF/StepParameters.md#getparameter>`__ -
   Returns an `FlowPDF::Parameter </doc/md/FlowPDF/Parameter.md>`__
   object or `FlowPDF::Credential </doc/md/FlowPDF/Credential.md>`__
   object.
-  `getRequiredParameter </doc/md/FlowPDF/StepParameters.md#getrequiredparameter>`__
   - Returns an FlowPDF::Parameter object or FlowPDF::Credential object
   if this parameter exists. If parameter does not exist, this method
   aborts execution with exit code 1.

FlowPDF::StepResult
-------------------

This class controls execution flow of the task or procedure. It is being
used for setting job/task outcome, setting output parameters, setting
pipeline summaries.

`FlowPDF::StepResult </doc/md/FlowPDF/StepResult.md>`__

-  `setJobStepOutcome </doc/md/FlowPDF/StepResult.md#setjobstepoutcome>`__
   - Schedules setting of a job step outcome. Could be warning, success
   or an error.
-  `setPipelineSummary </doc/md/FlowPDF/StepResult.md#setpipelinesummary>`__
   - Sets the summary of the current pipeline task.
-  `setJobStepSummary </doc/md/FlowPDF/StepResult.md#setjobstepsummary>`__
   - Sets the summary of the current job step.
-  `setJobSummary </doc/md/FlowPDF/StepResult.md#setjobsummary>`__ -
   Sets the summary of the current job.
-  `setOutcomeProperty </doc/md/FlowPDF/StepResult.md#setoutcomeproperty>`__
   - Sets the outcome property.
-  `setOutputParameter </doc/md/FlowPDF/StepResult.md#setoutputparameter>`__
   - Sets an output parameter.
-  `setReportUrl </doc/md/FlowPDF/StepResult.md#setoutputparameter>`__ -
   Sets the report URL for current Job.
-  `apply </doc/md/FlowPDF/StepResult.md#apply>`__ - Applies scheduled
   changes without schedule cleanup in queue order: first scheduled,
   first executed.
-  `flush </doc/md/FlowPDF/StepResult.md#flush>`__ - Flushes scheduled
   actions.
-  `applyAndFlush </doc/md/FlowPDF/StepResult.md#applyandflush>`__ -
   Executes the schedule queue and flushes it then.

FlowPDF::Client::REST
---------------------

A simple rest client that is being used across FlowPDF. It is should be
used for LWP::UserAgent and HTTP::Request objects retrieval.

`FlowPDF::Client::REST </doc/md/FlowPDF/Client/REST.md>`__

-  `new </doc/md/FlowPDF/Client/REST.md#new>`__ - Creates new
   FlowPDF::Client::REST object.
-  `newRequest </doc/md/FlowPDF/Client/REST.md#newrequest>`__ - Creates
   new supercharged HTTP::Request object.
-  `doRequest </doc/md/FlowPDF/Client/REST.md#dorequest>`__ - Performs
   http request using HTTP::Request object.
-  `augmentUrlWithParams </doc/md/FlowPDF/Client/REST.md#augmenturlwithparams>`__
   - Helper method, that provides a mechanism for adding query
   parameters to URL, with proper escaping.
