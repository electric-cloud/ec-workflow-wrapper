NAME
====

FlowPDF::Parameter

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class represents ElectricFlow parameters. It could be:

-  **Configuration Parameters**
-  **Procedure Parameters**

SYNOPSIS
========

Objects of this class have support of toString(). If this object will be
used in a string context like:

.. code:: perl


       my $parameter = $stepParameters->getParameter('query');
       print "Parameter: $parameter\n";

getValue() method will be applied automatically and you will get a value
instead of reference address.

This object is being returned by
`FlowPDF::Config <flowpdf-perl-lib/FlowPDF/Config.html>`__ or
`FlowPDF::StepParameters <flowpdf-perl-lib/FlowPDF/Config.html>`__ getParameter()
method.

`FlowPDF::StepParameters <flowpdf-perl-lib/FlowPDF/StepParameters.html>`__ object
is being returned by getStepParameters() method of
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/StepParameters.html>`__.

`FlowPDF::Config <flowpdf-perl-lib/FlowPDF/Config.html>`__ object is being returned
by getConfigValues method of
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Config.html>`__

METHODS
=======

getName()
---------

.. _description-1:

Description
~~~~~~~~~~~

Gets a name from FlowPDF::Parameter object.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (String) Name of the parameter.

Usage
~~~~~

.. code:: perl


       my $parameterName = $parameter->getName();

getValue()
----------

.. _description-2:

Description
~~~~~~~~~~~

Returns a value of the current parameter.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (String) Value of the parameter

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $parameterValue = $parameter->getValue();

Also, note, that **this method is being applied by default, if
FlowPDF::Parameter object is being used in string context**:

.. code:: perl


       # getValue is being applied automatically in string conext. Following 2 lines of code are doing the same:
       print "Query: $query\n";
       printf "Query: %s\n", $query->getValue();

   %%LANG

   ## setName($name)

   ### Description

   Sets a name for the current parameter.

   ### Parameters

   - (Required) (String) Parameter Name

   ### Returns

   - (FlowPDF::Parameter) self

   ### Usage

   ```perl

       $parameter->setName('myNewName');

setValue($value)
----------------

.. _description-3:

Description
~~~~~~~~~~~

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Required)(String) Parameter Value

.. _returns-2:

Returns
~~~~~~~

-  (FlowPDF::Parameter) self

.. _usage-2:

Usage
~~~~~

.. code:: perl


       $parameter->setValue('MyNewValue');


