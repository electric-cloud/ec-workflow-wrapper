# Public APIs of FlowPDF Perl SDK

This document exposes all currently available public methods by their classes.

## FlowPDF

This class is an entry point to all framework logic. This class is the class that is being extended by the main plugin class.

 * [newContext](/doc/md/FlowPDF.md#newcontext) - A method that creates new [FlowPDF::Context](/doc/md/FlowPDF/Context.md) object.
 * [getContext](/doc/md/FlowPDF.md#getcontext) - This method returns previously created context object. If there is no context object, it is being created and returned then.
 * [getPluginProjectName](/doc/md/FlowPDF.md#getpluginprojectname) - A method that returns a complete name of your plugin with version as string.
 
 
## FlowPDF::ComponentManager

This class is responsible for Components Ecosystem. Components is an extensions to the FlowPDF. Now we have following component available:

 * [FlowPDF::Component::Proxy](/doc/md/FlowPDF/Component/Proxy.md)
 * [FlowPDF::Component::CLI](/doc/md/FlowPDF/Component/CLI.md)
 * [FlowPDF::Component::OAuth](/doc/md/FlowPDF/Component/Oauth.md)

[FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md)

 * [new](/doc/md/FlowPDF/ComponentManager.md#new) - Creates new [FlowPDF::ComponentManager](/doc/md/FlowPDF/Context.md) object.
 * [loadComponent](/doc/md/FlowPDF/ComponentManager.md#loadcomponent) - Loads new component.
 * [loadComponentLocal](/doc/md/FlowPDF/ComponentManager.md#loadcomponentlocal) - Loads new component locally.
 * [getComponent](/doc/md/FlowPDF/ComponentManager.md#getcomponent) - Gets previously loaded component.
 * [getComponentLocal](/doc/md/FlowPDF/ComponentManager.md#getcomponentlocal) - Gets previously loaded local component.

## FlowPDF::Config

This class represents a plugin configuration object.

[FlowPDF::Config](/doc/md/FlowPDF/Config.md)

 * getParameter
 * getParametersList
 * getRequiredParameter
 * asHashref

## FlowPDF::Context

This class represents a context of the current runtime. Context allows to get context-dependent parameters,
set context-dependent properties, outcomes, summaries, control execution flow of current task.

[FlowPDF::Context](/doc/md/FlowPDF/Context.md)

 * [getRuntimeParameters](/doc/md/FlowPDF/Context.md#getruntimeparameters) - Returns a hashref of all runtime parameters. Step parameters + config values.
 * [getStepParameters](/doc/md/FlowPDF/Context.md#getstepparameters) - returns step parameters as [FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md) object.
 * [getConfigValues](/doc/md/FlowPDF/Context.md#getconfigvalues) - returns configuration values as [FlowPDF::Config](/doc/md/FlowPDF/Config.md) object.
 * [newStepResult](/doc/md/FlowPDF/Context.md#newstepresult) - returns an [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) object to set various output values during execution.
 * [newRESTClient](/doc/md/FlowPDF/Context.md#newrestclient) - returns [FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md) object for http interaction.
 * [bailOut](/doc/md/FlowPDF/Context.md#newrestclient) - works exactly as bailOut from FlowPDF::Helpers, but in addition it sets proper output properties, error messages and adds logs.

## FlowPDF::Credential

A credential representation. Stores ElectricFlow credetials.

[FlowPDF::Credential](/doc/md/FlowPDF/Credential.md)

 * [getCredentialType](/doc/md/FlowPDF/Credential.md#getcredentialtype) - Returns different values for different credentials type. For FlowPDF SDK Drop1 only default is supported.
 * [getUserName](/doc/md/FlowPDF/Credential.md#getusername) - Returns a user name that is being stored in the current credential.
 * [getSecretValue](/doc/md/FlowPDF/Credential.md#getsecretvalue) - Returns a secret value that is being stored in the current credential.
 * [getCredentialName](/doc/md/FlowPDF/Credential.md#getcredentialname) - Returns a name for the current credential.

## FlowPDF::Log

A class for logging.

[FlowPDF::Log](/doc/md/FlowPDF/Log.md)

 * [logInfo](/doc/md/FlowPDF/Log.md#loginfo) - Logs an info message. Output is the same as from print function.
 * [logDebug](/doc/md/FlowPDF/Log.md#logdebug) - Logs a debug message:
 * [logTrace](/doc/md/FlowPDF/Log.md#logtrace) - Logs a trace message
 * [logWarning](/doc/md/FlowPDF/Log.md#logwarning) - logs a warning message
 * [logError](/doc/md/FlowPDF/Log.md#logerror) - logs an error message.
 * [logInfoDiag](/doc/md/FlowPDF/Log.md#loginfodiag) - logs an info message and adds it to the Diagnostic tab of a Job.
 * [logWarningDiag](/doc/md/FlowPDF/Log.md#logwarningdiag) - logs a warning message and adds it to the Diagnostic tab of a Job.
 * [logErrorDiag](/doc/md/FlowPDF/Log.md#logerrordiag) - logs an error message and adds it to the Diagnostic tab of a Job.


## FlowPDF::Parameter

This class represents a regular parameter of procedure or configuration.

[FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md)

 * [getName](/doc/md/FlowPDF/Parameter.md#getname) - returns a name for the current parameter.
 * [getValue](/doc/md/FlowPDF/Parameter.md#getvalue) - returns a value for the current parameter.
 * [setName](/doc/md/FlowPDF/Parameter.md#setname) - sets a name for the current parameter.
 * [setValue](/doc/md/FlowPDF/Parameter.md#setvalue) - sets a value for the current parameter.

## FlowPDF::StepParameters

This class represents context-dependent parameters of current step. It is being created through context object.

[FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md)

 * [isParameterExists](/doc/md/FlowPDF/StepParameters.md#isparameterexists) - Returns true if parameter exists in the current step.
 * [getParameter](/doc/md/FlowPDF/StepParameters.md#getparameter) - Returns an [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object or [FlowPDF::Credential](/doc/md/FlowPDF/Credential.md) object.
 * [getRequiredParameter](/doc/md/FlowPDF/StepParameters.md#getrequiredparameter) - Returns an FlowPDF::Parameter object or FlowPDF::Credential object if this parameter exists.
   If parameter does not exist, this method aborts execution with exit code 1.
 * [asHashRef](/doc/md/FlowPDF/StepParameters.md#ashashref) - Returns a hash reference to step parameters.

## FlowPDF::StepResult

This class controls execution flow of the task or procedure. It is being used for setting job/task outcome, setting output parameters, setting pipeline summaries.

[FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md)

 * [setJobStepOutcome](/doc/md/FlowPDF/StepResult.md#setjobstepoutcome) - Schedules setting of a job step outcome. Could be warning, success or an error.
 * [setPipelineSummary](/doc/md/FlowPDF/StepResult.md#setpipelinesummary) - Sets the summary of the current pipeline task.
 * [setJobStepSummary](/doc/md/FlowPDF/StepResult.md#setjobstepsummary) - Sets the summary of the current job step.
 * [setJobSummary](/doc/md/FlowPDF/StepResult.md#setjobsummary) - Sets the summary of the current job.
 * [setOutcomeProperty](/doc/md/FlowPDF/StepResult.md#setoutcomeproperty) - Sets the outcome property.
 * [setOutputParameter](/doc/md/FlowPDF/StepResult.md#setoutputparameter) - Sets an output parameter.
 * [setReportUrl](/doc/md/FlowPDF/StepResult.md#setoutputparameter) - Sets the report URL for current Job.
 * [apply](/doc/md/FlowPDF/StepResult.md#apply) - Applies scheduled changes without schedule cleanup in queue order: first scheduled, first executed.
 * [flush](/doc/md/FlowPDF/StepResult.md#flush) - Flushes scheduled actions.
 * [applyAndFlush](/doc/md/FlowPDF/StepResult.md#applyandflush) - Executes the schedule queue and flushes it then.

## FlowPDF::Client::REST

A simple rest client that is being used across FlowPDF. It is should be used for LWP::UserAgent and HTTP::Request objects retrieval.

[FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md)

 * [new](/doc/md/FlowPDF/Client/REST.md#new) - Creates new FlowPDF::Client::REST object.
 * [newRequest](/doc/md/FlowPDF/Client/REST.md#newrequest) - Creates new supercharged HTTP::Request object.
 * [doRequest](/doc/md/FlowPDF/Client/REST.md#dorequest) - Performs http request using HTTP::Request object.
 * [augmentUrlWithParams](/doc/md/FlowPDF/Client/REST.md#augmenturlwithparams) - Helper method, that provides a mechanism for adding query parameters to URL, with proper escaping.

## FlowPDF::Exception

This class is a superclass for all exceptions that are present in FlowPDF.

Exceptions are:

 * [FlowPDF::Exception::EntityAlreadyExists](/doc/md/FlowPDF/Exception/EntityAlreadyExists.md)
 * [FlowPDF::Exception::EntityDoesNotExist](/doc/md/FlowPDF/Exception/EntityDoesNotExist.md)
 * [FlowPDF::Exception::MissingFunctionArgument](/doc/md/FlowPDF/Exception/MissingFunctionArgument.md)
 * [FlowPDF::Exception::MissingFunctionDefinition](/doc/md/FlowPDF/Exception/MissingFunctionDefinition.md)
 * [FlowPDF::Exception::RuntimeException](/doc/md/FlowPDF/Exception/RuntimeException.md)
 * [FlowPDF::Exception::UnexpectedEmptyValue](/doc/md/FlowPDF/Exception/UnexpectedEmptyValue.md)
 * [FlowPDF::Exception::UnexpectedMissingValue](/doc/md/FlowPDF/Exception/UnexpectedMissingValue.md)
 * [FlowPDF::Exception::WrongFunctionArgumentType](/doc/md/FlowPDF/Exception/WrongFunctionArgumentType.md)
 * [FlowPDF::Exception::WrongFunctionArgumentValue](/doc/md/FlowPDF/Exception/WrongFunctionArgumentValue.md)
 
Each exception class due to [FlowPDF::Exception](/doc/md/FlowPDF/Exception.md) superclass has the following methods:

 * new - creates a new exception object.
 * toString - converts an exception to string.
 * throw - throws an exception.
 * is - compares exeption with another exception object or class name and returns true if they has the same type/class, otherwise returns false.
 * getCode - returns exception code.
 * getMessage - Returns exception message
 * getCallInfo - Returns stack trace for exception.
 
## FlowPDF::Devel::Stacktrace

This class represents a stack trace. It is could be used in user-defined exceptions.

 * [new](/doc/md/FlowPDF/Devel/Stacktrace.md#new) - Returns a [FlowPDF:Devel::Stacktrace](/doc/md/FlowPDF/Devel/Stacktrace.md) object with stack trace at the moment of creation.
 * [toString](/doc/md/FlowPDF/Devel/Stacktrace.md#tostring) - Returns a string version of [FlowPDF:Devel::Stacktrace](/doc/md/FlowPDF/Devel/Stacktrace.md) object.
 * [clone](/doc/md/FlowPDF/Devel/Stacktrace.md#clone) - Returns clone of the caller object.
 
