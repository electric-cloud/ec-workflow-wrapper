NAME
====

FlowPDF::Exception::UnexpectedMissingValue

AUTHOR
======

CloudBees

DESCRIPTION
===========

An exception that represents a situation when a required or mandatory
value is missing.

USAGE
=====

This exception could be created using new() method in one of the
following ways:

-  No parameters

   Exception with default message will be created.

-  Custom scalar parameter

   Exception with custom message will be created.

-  hashref with the following fields as parameter:

   **Note:** you may not use all of these arguments at once. It is
   allowed to omit some of them.

   -  where

      A description where it happened.

   -  expected

      An expected value.

::


   FlowPDF::Exception::UnexpectedMissingValue->new({
       where => 'function result',
       expected => 'non-empty value'
   })->throw();


