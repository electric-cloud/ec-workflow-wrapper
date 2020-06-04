NAME
====

FlowPDF::Exception::RuntimeException

AUTHOR
======

CloudBees

DESCRIPTION
===========

An exception that represents a generic runtime exception.

USAGE
=====

This exception could be created using new() method in one of the
following ways:

-  No parameters

   Exception with default message will be created.

-  Custom scalar parameter

   Exception with custom message will be created.

::


   FlowPDF::Exception::RuntimeException->new("Error evaluating code.")->throw();


