NAME
====

FlowPDF::Exception::MissingFunctionArgument

AUTHOR
======

CloudBees

DESCRIPTION
===========

An exception that represents a situation when function didn't receive a
mandatory parameter.

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

   -  argument

      An argument, that is missing.

   -  function

      A name of the function, that didn't receive a mandatory argument.

::


   FlowPDF::Exception::MissingFunctionArgument->new({
       argument => 'user name',
       function => 'greetUser'
   })->throw();


