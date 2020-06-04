NAME
====

FlowPDF::Exception::WrongFunctionArgumentType

AUTHOR
======

CloudBees

DESCRIPTION
===========

An exception that represents a situation when function received an
argument of a type, that is not suitable.

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

      An argument, that has a wrong type.

   -  function

      A name of the function, that received an argument of a wrong type.

   -  got

      A type of argument that were gotten.

   -  expected

      An expected type of an argument.

::


   FlowPDF::Exception::MissingFunctionArgument->new({
       argument => 'user name',
       function => 'greetUser',
       got      => 'HASH',
       expected => 'scalar'
   })->throw();


