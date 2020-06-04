NAME
====

FlowPDF::Component::EF::Reporting::Data

AUTHOR
======

CloudBees

DESCRIPTION
===========

A data object.

METHODS
=======

getReportObjectType()
---------------------

.. _description-1:

Description
~~~~~~~~~~~

Returns a report object type for current data.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (String) Report object type for current data.

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

.. code:: perl


       my $reportObhectType = $data->getReportObjectType();

getValues()
-----------

.. _description-2:

Description
~~~~~~~~~~~

Returns a values for the current data.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (HASH ref) A values for the current data.

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $values = $data->getValues();

addOrUpdateValue
----------------

.. _description-3:

Description
~~~~~~~~~~~

Adds or updates a value for the current data object.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Required)(String) Key for the data.
-  (Required)(String) Value for the data.

.. _returns-2:

Returns
~~~~~~~

-  Reference to the current FlowPDF::Component::EF::Reporting::Data

.. _exceptions-1:

Exceptions
~~~~~~~~~~

-  None

.. _usage-2:

Usage
~~~~~

.. code:: perl


       $data->addOrUpdateValue('key', 'value')

addValue
--------

.. _description-4:

Description
~~~~~~~~~~~

Adds a new value to the data values, falls with exceptions if provided
key already exists.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (Required)(String) Key for the data.
-  (Required)(String) Value for the data.

.. _returns-3:

Returns
~~~~~~~

-  Reference to the current FlowPDF::Component::EF::Reporting::Data

.. _exceptions-2:

Exceptions
~~~~~~~~~~

-  Fatal error if field already exists.

.. _usage-3:

Usage
~~~~~

.. code:: perl


       $data->addValue('key', 'value')

updateValue
-----------

.. _description-5:

Description
~~~~~~~~~~~

Updates a value for current data values. Fatal error if value does not
exist.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  (Required)(String) Key for the data.
-  (Required)(String) Value for the data.

.. _returns-4:

Returns
~~~~~~~

-  Reference to the current FlowPDF::Component::EF::Reporting::Data

.. _exceptions-3:

Exceptions
~~~~~~~~~~

-  Fatal exception if value does not exist.

.. _usage-4:

Usage
~~~~~

.. code:: perl


       $data->updateValue('key', 'value')


