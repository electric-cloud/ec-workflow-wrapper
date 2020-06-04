NAME
====

FlowPDF::Component::EF::Reporting

AUTHOR
======

CloudBees

COMPONENT STATE
===============

Current state of this component is late alpha version. Drop 1.

Currently, the state of this component allows you to implement
CollectReportingData procedure for single payload-type per module.

However, multiple payload are designed, but not implemented yet. This
will be a goal for the Drop 2.

DESCRIPTION
===========

This module provides a component for Release Command Center (RCC)
integration.

Before this component created, implementation of RCC integration was
very complex and hard to setup.

This component provides a unified interface for RCC integrations using
FlowPDF-Perl toolkit.

TERMINOLOGY
===========

-  Devops Insight Center

   DevOps Insight provides dashboards that give you insights into
   deployment and release activities over time.

   The ability to visualize this information as dashboards enables
   enterprises to understand the overall status of their processes,
   identify hotspots that need action, understand trends, and find
   opportunities for further improvement. DevOps Insight provides
   several dashboards as well as the ability to create custom
   dashboards.

   These dashboards include the Release Command Center dashboard, which
   provides a centralized view of all activities and processes related
   to a release.

   These include key metrics from the tools used across the end-to-end
   process, from work item tracking and build automation to test and
   operations tools.

   The Release Command Center dashboard helps you to understand how many
   user stories are planned, how many of them are "dev complete", how
   many are tested, what is the success rate of each of them, and other
   metrics that can help you better manage software production.

-  Release Command Center

   Release Command Center is a part of Devops Insight Center and it
   shows a metrics that are gathered from different datasource of
   different types.

-  Data source

   A system from where we're retrieving data for Devops Insight Center
   to shot them in Release Command Center.

   It could be, basically, any kind of third-party software. For
   example, Jenkins, Jira, ServiceNow, SonarQube, etc.

-  Report Object Type

   Each kind of report has it's own object type. Report object type
   defines a place where collected data will be shown.

   For example, Jenkins datasource has report object type "build" for
   builds and "quality" for test reports.

   JIRA has 'feature' for improvement tickets, and "defect" for bug
   issues. ServiceNow has an "incident" report object type.

-  Payload

   Payload is a data that represents single entity for each report
   object type. For example, if we're collecting reporting data from
   jenkins

   for HelloWorld project, we will have a payload object of a build type
   for each build that were already built.

   So, if we have 10 builds, we should send 10 payloads.

   Each payload of certain report object type has its own set of defined
   fields that should be sent.

   We're building payloads from the data, that is being retrieved from
   data source.

-  Records set

   Records set is a raw data that is retrieved from data source. It
   should be an array of hashes.

-  Data set

   Data set is an array of hashes (dicts) that is created from records
   set. In that case it should be a flat array of a flat hashes.

   So, each of hashes should have only a scalar values for its keys.

-  Payload set

   Payload set is a set of payloads, that are already prepared to be
   sent to the reporting system.

-  Transform script

   A script that is provided by user using procedure form or directly to
   be applied to each record in records set.

-  Metadata

   An information that allows reporting system to know last reported
   object. It is being built from latest payload that was sent.

   Metadata is being stored as JSON in the property. The address of
   these property is could be default or set by user.

   Default place of property is depends on the context. For regular
   context it will be set to the current project.

   In context of schedule it will be stored in the schedule properties.

Data Flow
=========

Datasource => Records Set => Transformed Records Set => Data Set =>
Payload Set

The key idea of reporting is:

-  Read data from datasource (jira, jenkins, etc) about some metric
   (issues count, build status, etc).
-  Create a set of payloads from retrieved dataset.
-  Send it to EF instance.
-  Write a fingerprint (we call it metadata) of latest payload and store
   it somewhere.
-  On the next run, validate metadata to make sure that we need or need
   no of new reports.

WHAT DO YOU NEED TO IMPLEMENT REPORTING?
========================================

To implement reporting you need to have the following things (if you
have all of them, reporting implementation for your plugin is simple
enough).

-  An unique key/metric/value of each record/payload.

   This value will be your keypoint of reporting. This value should be
   unique and you should have a way of comparison between two values, to
   get which is later. For example, in Jenkins it is a build number.
   Build number is an unique value of each build inside a jenkins
   project. Let's say, that we did a successful reporting of set of
   jenkins builds, and latest was 42. Then, someone triggering a new
   build, and latest build number is 43 now. That is, we can easily
   compare 42 and 43 and understand, that if new build number is more
   than latest stored, we need to report.

-  An API that allows you to get latest record.

   When it is possible to get a latest record by your criteria from
   datasource, you can

.. _how-to-implement-reporting:

How to implement reporting.
===========================

To get reporting one need to create a subclass of
FlowPDF::Component::EF::Reporing within your project and implement
following functions:

-  compareMetadata($localMetadata, $latestRemoteMetadata);

   A metadata comparator. It should work exactly as cmp, <=> or any
   other sort function.

   If your metadata that is stored on EF side is pointing on non-latest
   data, simply return 1, it will trigger all logic.

   Note: You don't have to create metadata object by yourself. This part
   is being handled by this component behind the scene. For list of
   available methods of metadata object refer to:
   `FlowPDF::Component::EF::Reporting::Metadata <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Metadata.html>`__.

   Note: Result of all getter functions, that return an array reference
   should be ordered from older to newer. This will be checked during
   validation and procedure will fail if records are not sorted in
   proper order. For this validation function that has been written for
   metadata comparison by user will be used. For example, if you have a
   set of builds with 10, 11, and 48, they should go in the following
   order: [10, 11, 48], otherwise procedure will raise an exception.

-  initialGetRecords($pluginObject, $limit);

   Function that is responsible for initial data retrieval. It will have
   as parameter $limit. If limit is not passed or it is equals to 0, no
   limit is to be applied.

-  getRecordsAfter($pluginObject, $metadata);

   A function that retrieves a newer records than a record that is
   stored on the EF side in metadata.

-  getLastRecord($pluginObject);

   A function that always return a last record. This function should
   returh a hash reference instead of array of hash references.

-  buildDataset($pluginObject, $records);

   A function that gets records set as parameter and builds a dataset
   from them.

   Note, that transformation script is being applied right before this
   function automatically.

-  buildPayloadset($pluginObject, $dataset);

   This function builds a payload set from dataset.

   Note, that after this function validation of each payload will be
   performed, and if something is not correct, procedure will bail out.

.. _how-to-implement-reporting-1:

HOW TO IMPLEMENT REPORTING?
===========================

There are few steps to achieve that:

-  Inherit this class.

   .. code:: perl


          package EC::Plugin::YourPlugin::Reporting;
          use base qw/FlowPDF::Component::EF::Reporting/;

-  Define a procedure for reporting (now manually, in the drop2 - using
   ecpdk).

-  Load component that you just created and define it:

   .. code:: perl


          my $reporting = FlowPDF::ComponentManager->loadComponent('EC::Plugin::YourPlugin::Reporting', {
              reportObjectTypes => ['build'],
              metadataUniqueKey => $params->{jobName},
              payloadKeys => ['buildNumber']
          }, $pluginObject);

   Where:

   -  reportObjectTypes

      An array reference of report object types that are supported by
      your component.

   -  metadataUniqueKey

      An unique key for metadata. It will be used to store metadata for
      different datasource entities in the different paths.

      It should be set to some value. For example, if you have a
      parameter for the jenkins job, that should be reported, you may
      set this to it's value, like HelloWorld. Basically, you can use
      any string here. But you need to be sure, that your unique key is
      really unique and you can use it for further metadata retrieval.
      So, do not use any random values there.

   -  payloadKeys

      The fields of payload that will be used for metadata creation. An
      array reference of scalars. These fields should be present in
      payload.

      If not, procedure will be failed. For example, if you have in
      payload buildNumber field, and you want to have this number as
      identifier, provide just ['buildNumber'].

-  Call CollectReportingData() from your component

   .. code:: perl


          $reporting->collectReportingData();

EXAMPLE
=======

This example demonstrates how it is possible to create
CollectReportingData using this component manually.

.. code:: perl


       package EC::Plugin::NewJenkins::Reporting;
       use Data::Dumper;
       use base qw/FlowPDF::Component::EF::Reporting/;
       use FlowPDF::Log;
       use strict;
       use warnings;

       sub compareMetadata {
           my ($self, $metadata1, $metadata2) = @_;
           my $value1 = $metadata1->getValue();
           my $value2 = $metadata2->getValue();
           # Implement here logic of metadata values comparison.
           # Return 1 if there are newer records than record to which metadata is pointing.
           return 1;
       }


       sub initialGetRecords {
           my ($self, $pluginObject, $limit) = @_;

           # build records and return them
           my $records = $pluginObject->yourMethodTobuildTheRecords($limit);
           return $records;
       }


       sub getRecordsAfter {
           my ($self, $pluginObject, $metadata) = @_;

           # build records using metadata as start point using your functions
           my $records = $pluginObject->yourMethodTobuildTheRecordsAfter($metadata);
           return $records;
       }

       sub getLastRecord {
           my ($self, $pluginObject) = @_;

           my $lastRecord = $pluginObject->yourMethodToGetLastRecord();
           return $lastRecord;
       }

       sub buildDataset {
           my ($self, $pluginObject, $records) = @_;

           my $dataset = $self->newDataset(['yourReportObjectType']);
           for my $row (@$records) {
               # now, data is a pointer, you need to populate it by yourself using it's methods.
               my $data = $dataset->newData({
                   reportObjectType => 'yourReportObjectType',
               });
               for my $k (keys %$row) {
                   $data->{values}->{$k} = $row->{$k};
               }
           }
           return $dataset;
       }

METHODS
=======

CollectReportingData()
----------------------

.. _description-1:

Description
~~~~~~~~~~~

Executes CollectReportingData logic and sends a reports to the Devops
Insight Center.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  None

Exceptions
~~~~~~~~~~

Throws a fatal error and exits with code 1 if something went wrong.

Usage
~~~~~

.. code:: perl


       $reporting->CollectReportingData();

newDataset($reportObjectTypes, $records);
-----------------------------------------

.. _description-2:

Description
~~~~~~~~~~~

Creates a new
`FlowPDF::Component::EF::Reporting::Dataset <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Dataset.html>`__
object from records set.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (Required)(ARRAY ref of scalars) A report object types to be used for
   dataset creation.
-  (Optional)(ARRAY ref or records) A list of
   `FlowPDF::Component::EF::Reporting::Data <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Data.html>`__
   objects.

.. _returns-1:

Returns
~~~~~~~

-  `FlowPDF::Component::EF::Reporting::Dataset <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Dataset.html>`__

.. _exceptions-1:

Exceptions
~~~~~~~~~~

Throws a missing parameters exception.

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $dataset = $reporting->newDataset(['build']);

newPayloadset($reportObjectTypes, $payloads);
---------------------------------------------

.. _description-3:

Description
~~~~~~~~~~~

Creates a new
`FlowPDF::Component::EF::Reporting::Payloadset <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payloadset.html>`__
object from records set.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Required)(ARRAY ref of scalars) A report object types to be used for
   payload creation.
-  (Optional)(ARRAY ref or records) A list of
   `FlowPDF::Component::EF::Reporting::Payload <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payload.html>`__
   objects.

.. _returns-2:

Returns
~~~~~~~

-  `FlowPDF::Component::EF::Reporting::Payloadset <flowpdf-perl-lib/FlowPDF/Component/EF/Reporting/Payloadset.html>`__

.. _exceptions-2:

Exceptions
~~~~~~~~~~

Throws a missing parameters exception.

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $payloadset = $reporting->newPayloadset(['build']);


