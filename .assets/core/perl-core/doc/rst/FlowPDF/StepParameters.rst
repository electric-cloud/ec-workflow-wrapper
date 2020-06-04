NAME
====

FlowPDF::StepParameters

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class represents current step parameters, that are defined for
current procedure step or current pipeline task.

SYNOPSIS
========

To get a FlowPDF::StepParameters object you need to use
getStepParameters() method from
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__.

METHODS
=======

isParameterExists()
-------------------

.. _description-1:

Description
~~~~~~~~~~~

Returns true if parameter exists in the current step.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (Boolean) True if parameter exists.

Usage
~~~~~

.. code:: perl


       if ($stepParameters->isParameterExists('query')) {
           ...;
       }

getParameter($parameterName)
----------------------------

.. _description-2:

Description
~~~~~~~~~~~

Returns an `FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object
or `FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (String) Name of parameter to get.

.. _returns-1:

Returns
~~~~~~~

-  (`FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__\ \|\ `FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Parameter.html>`__)
   Parameter or credential by it's name

.. _usage-1:

Usage
~~~~~

To get parameter object:

.. code:: perl


       my $query = $stepParameters->getParameter('query');

If your parameter is an
`FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object, you can
get its value either by getValue() method, or using string context:

.. code:: perl


       print "Query:", $query->getValue();

Or:

.. code:: perl


       print "Query: $query"

If your parameter is
`FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Credential.html>`__, follow its own
documentation.

getRequiredParameter($parameterName)
------------------------------------

.. _description-3:

Description
~~~~~~~~~~~

Returns an `FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object
or `FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object if this
parameter exists.

If parameter does not exist, this method aborts execution with exit code
1.

This exception can't be catched.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (String) Name of parameter to get.

.. _returns-2:

Returns
~~~~~~~

-  (`FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__\ \|\ `FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Parameter.html>`__)
   Parameter or credential by it's name

.. _usage-2:

Usage
~~~~~

To get parameter object:

.. code:: perl


       my $query = $stepParameters->getRequiredParameter('query');

If your parameter is an
`FlowPDF::Parameter <flowpdf-perl-lib/FlowPDF/Parameter.html>`__ object, you can
get its value either by getValue() method, or using string context:

.. code:: perl


       print "Query:", $query->getValue();

Or:

.. code:: perl


       print "Query: $query"

If your parameter is
`FlowPDF::Credential <flowpdf-perl-lib/FlowPDF/Credential.html>`__, follow its own
documentation.

asHashref()
-----------

.. _description-4:

Description
~~~~~~~~~~~

This function returns a HASH reference that is made from
FlowPDF::StepParameters object. Where key is a name of parameter and
value is a value of parameter.

For credentials the same pattern as for getRuntimeParameters from
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__ is being followed.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  None

.. _returns-3:

Returns
~~~~~~~

-  (HASH reference) A HASH reference to a HASH with step parameters.

Exceptions
~~~~~~~~~~

-  None

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $stepParameters = $context->getStepParameters()->asHashref();
       logInfo("Application path is: $stepParameters->{applicationPath}");


