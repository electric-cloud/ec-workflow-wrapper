NAME
====

FlowPDF::Component::EF::Reporting::Dataset

AUTHOR
======

CloudBees

DESCRIPTION
===========

A dataset object.

METHODS
=======

getReportObjectTypes()
----------------------

.. _description-1:

Description
~~~~~~~~~~~

Returns a report object types for current dataset.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (ARRAY ref) Report object types for current dataset

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

.. code:: perl


       my $reportObjectTypes = $dataset->getReportObjectTypes();

getData()
---------

.. _description-2:

Description
~~~~~~~~~~~

Returns an ARRAY ref with data objects for current dataset.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (ARRAY ref of
   `FlowPDF::Component::EF::Reporting::Data <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Data.html>`__)
   An array reference of Data object for the current Dataset object.

.. _exceptions-1:

Exceptions
~~~~~~~~~~

-  None

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $data = $dataset->getData();

newData($params)
----------------

.. _description-3:

Description
~~~~~~~~~~~

Creates a new data object and adds it to the current dataset and returns
a reference for it.

.. _parameters-2:

Parameters
~~~~~~~~~~

A hash reference with following fields

-  (Required)(String) reportObjectType: a report object type for the
   current data
-  (Optional)(HASH ref) values: a values from which data object will be
   created.

.. _returns-2:

Returns
~~~~~~~

-  (`FlowPDF::Component::EF::Reporting::Data <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Data.html>`__)
   A reference to newly created data.

.. _exceptions-2:

Exceptions
~~~~~~~~~~

-  Fatal error if required fields are missing.

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $data = $dataset->newData({
           reportObjectType => 'build',
           values => {
               buildNumber => '2',
               status => 'success',
           }
       });


