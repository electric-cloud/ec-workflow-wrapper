NAME
====

FlowPDF::Component::EF::Reporting::Payload

AUTHOR
======

CloudBees

DESCRIPTION
===========

A payload object.

METHODS
=======

getReportObjectType()
---------------------

.. _description-1:

Description
~~~~~~~~~~~

Returns a report object type for current payload.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (String) Report object type for current payload

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

.. code:: perl


       my $reportObhectType = $payload->getReportObjectType();

getValues()
-----------

.. _description-2:

Description
~~~~~~~~~~~

Returns a values that will be sent for the current payload.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (HASH ref) A values for the current payload to be sent.

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $values = $payload->getValues();

getDependentPayloads()
----------------------

Note
~~~~

**This method still experimental**

.. _description-3:

Description
~~~~~~~~~~~

This method returns a dependent payloads for the current payload.

This method may be used when there is more than one report object type
should be send in the context of a single payload.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  None

.. _returns-2:

Returns
~~~~~~~

-  (ARRAY ref of FlowPDF::Component::EF::Reporting::Payload)

.. _exceptions-1:

Exceptions
~~~~~~~~~~

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $payloads = $payload->getDependentPayloads();


