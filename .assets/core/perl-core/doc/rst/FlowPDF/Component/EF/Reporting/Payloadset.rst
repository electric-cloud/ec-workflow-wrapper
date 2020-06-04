NAME
====

FlowPDF::Component::EF::Reporting::Payloadset

AUTHOR
======

CloudBees

DESCRIPTION
===========

A payloadset object.

METHODS
=======

getReportObjectTypes()
----------------------

.. _description-1:

Description
~~~~~~~~~~~

Returns an array reference of string report object types for current set
of payloads

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (ARRAY ref) Report object types

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

.. code:: perl


       my $reportObjectTypes = $payloadSet->getReportObjectTypes();

getPayloads()
-------------

.. _description-2:

Description
~~~~~~~~~~~

Returns an array references to the payloads.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (ARRAY ref) of
   `FlowPDF::Component::EF::Reporting::Payload <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payload.html>`__

.. _exceptions-1:

Exceptions
~~~~~~~~~~

-  None

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $payloads = $payloadset->getPayloads();

newPayload($params)
-------------------

.. _description-3:

Description
~~~~~~~~~~~

Creates a new payload and adds it to current payload set and returns a
reference for it.

.. _parameters-2:

Parameters
~~~~~~~~~~

A hash reference with following fields

-  (Required)(String) reportObjectType: a report object type for the
   current payload
-  (Optional)(HASH ref) values: a values that will be send to the Devops
   Insight Center. An actual payload.

.. _returns-2:

Returns
~~~~~~~

-  (`FlowPDF::Component::EF::Reporting::Payload <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payload.html>`__)
   A reference to newly created payload.

.. _exceptions-2:

Exceptions
~~~~~~~~~~

-  Fatal error if required fields are missing.

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $payload = $payloadSet->newPayload({
           reportObjectType => 'build',
           values => {
               buildNumber => '2',
               status => 'success',
           }
       });

.. _newpayloadparams-1:

newPayload($params)
-------------------

.. _description-4:

Description
~~~~~~~~~~~

Returns an array reference of string report object types for current set
of payloads

.. _parameters-3:

Parameters
~~~~~~~~~~

A hash reference with following fields

-  (Required)(String) reportObjectType: a report object type for the
   current payload
-  (Optional)(HASH ref) values: a values that will be send to the Devops
   Insight Center. An actual payload.

.. _returns-3:

Returns
~~~~~~~

-  (`FlowPDF::Component::EF::Reporting::Payload <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payload.html>`__)
   A reference to newly created payload.

.. _exceptions-3:

Exceptions
~~~~~~~~~~

-  Fatal error if required fields are missing.

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $payload = $payloadSet->newPayload({
           reportObjectType => 'build',
           values => {
               buildNumber => '2',
               status => 'success',
           }
       });

getLastPayload()
----------------

.. _description-5:

Description
~~~~~~~~~~~

Returns the last payload from current Payloadset.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  None

.. _returns-4:

Returns
~~~~~~~

-  (`FlowPDF::Component::EF::Reporting::Payload <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payload.html>`__)
   A reference to the last payload.

.. _exceptions-4:

Exceptions
~~~~~~~~~~

-  None

.. _usage-4:

Usage
~~~~~

.. code:: perl


       my $lastPayload = $payloadSet->getLastPayload();


