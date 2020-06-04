NAME
====

FlowPDF::Context

AUTHOR
======

CloudBees

DESCRIPTION
===========

FlowPDF::Context is a class that represents current running context.

This class allows user to access procedure parameters, config values and
define a step result.

METHODS
=======

bailOut($params)
----------------

.. _description-1:

Description
~~~~~~~~~~~

An advanced version of bailOut from
`FlowPDF::Helpers <flowpdf-perl-lib/FlowPDF/Helpers.html>`__::bailOut. This version
has connections with CloudBees Flow and has following benefits:

-  Sets a Pipeline Summary.
-  Sets a JobStep Summary.
-  Sets outcome to Error.
-  Adds diagnostic messages to Diagnostic tab of the job.
-  Add suggestion if provided.

Parameters
~~~~~~~~~~

-  (Required)(HASH ref) A hash reference with message and suggestion
   fields. Message is mandatory, suggestion is optional

Returns
~~~~~~~

-  None

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

This function is being used through context object. Also, note, that
this function created it's own
`FlowPDF::StepResult <flowpdf-perl-lib/FlowPDF/StepResult.html>`__ object. It
means, that if this function is being used, no other
`FlowPDF::StepResult <flowpdf-perl-lib/FlowPDF/StepResult.html>`__ objects will be
auto-applied.

This function uses bailOut function from
`FlowPDF::Helpers <flowpdf-perl-lib/FlowPDF/Helpers.html>`__ package and causes an
exception, that could not be handled and your step will exit
immedieately with code 1.

.. code:: perl


   \# this function will call an exit 1.
   $context->bailOut({
       message    => "File not found",
       suggestion => 'Please, check that you are using correct resource.'
   });

getRuntimeParameters()
----------------------

.. _description-2:

Description
~~~~~~~~~~~

A simplified accessor for the step parameters and config values. This
function returns a regular perl HASH ref from parameters and config
values.

Credentials from 'credential' parameter will be present in this hashref
as 'user' and password. Credentials, that have name like
'proxy_credential' will be mapped to 'proxy_user' and 'proxy_password'
parameters.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (HASH ref) A merged parameters from step parameters and config
   values.

.. _usage-1:

Usage
~~~~~

For example, you have 'query' parameter and 'location' parameter in your
procedure form.xml. In your configuration you have 'credential',
'proxy_credential', 'contentType' and 'userAgent'. In that case you can
get runtime parameters like:

.. code:: perl


       my $simpleParams = $context->getRuntimeParameters();

Now, $simpleParams is:

.. code:: perl


       {
           # Values from config
           user => 'admin',
           password => '12345',
           proxy_user => 'proxy',
           proxy_password => 'qwerty',
           contentType => 'application/json',
           userAgent => 'Mozilla',
           # values from step parameters
           location => 'California',
           query => 'SELECT * FROM commander.plugins'
       }

getStepParameters()
-------------------

.. _description-3:

Description
~~~~~~~~~~~

Returns a
`FlowPDF::StepParameters <flowpdf-perl-lib/FlowPDF/StepParameters.html>`__ object
to be used as accessor for current step parameters. This method does not
require parameters.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  None

.. _returns-2:

Returns
~~~~~~~

-  (`FlowPDF::StepParameters <flowpdf-perl-lib/FlowPDF/StepParameters.html>`__)
   Parameters for the current step

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $params = $context->getStepParameters();
       # this method returns a L<FlowPDF::Parameter> object, or undef, if no parameter with that name has been found.
       my $param = $params->getParameter('myStepParameter');
       if ($param) {
           print "Param value is:", $param->getValue(), "\n";
       }

getConfigValues()
-----------------

.. _description-4:

Description
~~~~~~~~~~~

This method returns a `FlowPDF::Config <flowpdf-perl-lib/FlowPDF/Config.html>`__
object that represents plugin configuration. This method does not
require parameters.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  None

.. _returns-3:

Returns
~~~~~~~

-  (`FlowPDF::Config <flowpdf-perl-lib/FlowPDF/Config.html>`__) Plugin
   configuration for current run context

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $configValues = $context->getConfigValues();
       my $cred = $configValues->getParameter('credential');
       if ($cred) {
           print "Secret value is: ", $cred->getSecretValue(), "\n";
       }

newStepResult()
---------------

.. _description-5:

Description
~~~~~~~~~~~

This method returns an
`FlowPDF::StepResult <flowpdf-perl-lib/FlowPDF/StepResult.html>`__ object, which is
being used to work with procedure or pipeline stage output.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  None

.. _returns-4:

Returns
~~~~~~~

-  (`FlowPDF::StepResult <flowpdf-perl-lib/FlowPDF/StepResult.html>`__) Object for
   manipulation with pipeline/procedure results.

.. _usage-4:

Usage
~~~~~

.. code:: perl


       my $stepResult = $context->newStepResult();
       ...;
       $stepResult->apply();

newRESTClient($creationParams)
------------------------------

.. _description-6:

Description
~~~~~~~~~~~

Creates an `FlowPDF::Client::REST <flowpdf-perl-lib/FlowPDF/Client/REST.html>`__
object, applying components and other useful mechanisms to it during
creation.

For now, this method supports following components and tools:

-  `FlowPDF::Component::Proxy <flowpdf-perl-lib/FlowPDF/Component/Proxy.html>`__

   Proxy can be automatically be enabled. To do that you need to make
   sure that following parameters are present in your configuration:

   -  credential with the proxy_credential name.
   -  regular parameter with httpProxyUrl name

   If your configuration has all fields above, proxy component will be
   applied silently, and you can be sure, that all requests that you're
   doing through
   `FlowPDF::Client::REST <flowpdf-perl-lib/FlowPDF/Client/REST.html>`__ methods
   already have proxy enabled.

   Also, note that if you have debugLevel parameter in your
   configuration, and it will be set to debug, debug mode for
   FlowPDF::ComponentProxy will be enabled by default.

-  Basic Authorization

   Basic authorization can be automatically applied to all your rest
   requests. To do that you need to make sure that following parameters
   are present in your plugin configuration:

   -  authScheme parameter has value "basic"
   -  credential with the basic_credential name

.. _parameters-5:

Parameters
~~~~~~~~~~

-  (Optional) (HASHREF) FlowPDF::Client::REST Object creation params.

.. _returns-5:

Returns
~~~~~~~

-  `FlowPDF::Client::REST <flowpdf-perl-lib/FlowPDF/Client/REST.html>`__

.. _usage-5:

Usage
~~~~~

.. code:: perl


       my $rest = $context->newRestClient();
       my $req = $rest->newRequest(GET => 'https://electric-cloud.com');
       my $response = $rest->doRequest($req);
       print $response->decoded_content();


