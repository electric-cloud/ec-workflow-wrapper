NAME
====

FlowPDF

AUTHOR
======

CloudBees

DESCRIPTION
===========

FlowPDF is an Flow Plugin Development Framework.

This tool has been created to make plugin development easier.

To use it one should extend this class and define pluginInfo which
should return a hash reference with following fields:

-  **pluginName**

   A name of the plugin. @PLUGIN_KEY@ could be used to be replaced with
   plugin name during plugin build-time.

-  **pluginVersion**

   A version of the plugin. @PLUGIN_VERSION@ could be used to be
   replaced with version during build-time.

-  **configFields**

   An array reference, that represents fields that would be used by
   plugin as a reference to plugin configurations. For example, one
   could use ['config', 'configName'] to say that config name could be
   found in these parameter values.

   **IMPORTANT** This list will be used from left to right, so, in
   example above configName will be used only if there is no procedure
   parameter with name 'config'.

-  **configLocations**

   An array reference with locations of plugin configurations. In all
   new plugins it will be set to ['ec_plugin_cfgs']. Precedence is the
   same, as in configFields.

SYNOPSIS
========

Example of a plugin main class:

.. code:: perl


       package EC::Plugin::NewRest;
       use strict;
       use warnings;
       use base qw/FlowPDF/;
       # Service function that is being used to set some metadata for a plugin.
       sub pluginInfo {
           return {
               pluginName    => '@PLUGIN_KEY@',
               pluginVersion => '@PLUGIN_VERSION@',
               configFields  => ['config'],
               configLocations => ['ec_plugin_cfgs']
           };
       }
       sub step_do_something {
           my ($pluginObject) = @_;
           my $context = $pluginObject->newContext();
           # This will show where we are. It could be procedure, pipeline or schedule
           print "Current context is: ", $context->getRunContext(), "\n";
           # This will get a step parameters.
           # $params now will be an L<FlowPDF::StepParameters> object.
           my $params = $context->getStepParameters();
           # This gets $headers parameter that is being stored under request_headers field of procedure.
           # To get value of this parameter one should 1. get parameter object 2. get a value if it is defined
           my $headers = $params->getParameter('request_headers');
           # This will return a config values for current procedure including credentials.
           # For configuration lookup see section above.
           my $configValues = $context->getConfigValues();
           # This creates a step result object, which handles actions that should be done during or after step execution
           my $stepResult = $context->newStepResult();
           # schedule setting a job step outcome to warning
           $stepResult->setJobStepOutcome('warning');
           # schedule setting a whole job summary:
           $stepResult->setJobSummary("See, this is a whole job summary");
           # schedule setting a current jobstep summary
           $stepResult->setJobStepSummary('And this is a job step summary');
           # abd, finally, apply all scheduled settings.
           $stepResult->apply();
       }

METHODS
=======

newContext()
------------

.. _description-1:

Description
~~~~~~~~~~~

Creates `FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__ object. Does
not require any additional parameters.

Please, note, that this function always creates a new context object.

If you want to use already existing context object, consider to use a
getContext() method.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  `FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__

.. code:: perl


       my $context = $pluginObject->newContext();

getContext()
------------

.. _description-2:

Description
~~~~~~~~~~~

This method returns already created
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__ object. Does not
require any additional parameters.

If this method is being used first time, it creates new context object
and returns it. Each next call will return exactly this object.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  `FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__

.. code:: perl


       my $context = $pluginObject->getContext();

getPluginProjectName()
----------------------

.. _description-3:

Description
~~~~~~~~~~~

This method returns a complete name of your plugin with version as
string.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  None

.. _returns-2:

Returns
~~~~~~~

-  (String) PluginName-PluginVersion;

.. code:: perl


       my $pluginProjectName = $pluginObject->getPluginProjectName();

SEE ALSO
========

`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__
-------------------------------------------------

`FlowPDF::StepResult <flowpdf-perl-lib/FlowPDF/StepResult.html>`__
-------------------------------------------------------

`FlowPDF::Config <flowpdf-perl-lib/FlowPDF/Config.html>`__
-----------------------------------------------
