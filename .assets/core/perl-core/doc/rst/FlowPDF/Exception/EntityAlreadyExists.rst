NAME
====

FlowPDF::Exception::EntityAlreadyExists

AUTHOR
======

CloudBees

DESCRIPTION
===========

An exception that represents a situation when something already exists,
but it should not. Like user with the same email in the database.

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

   -  entity

      An entity, that already exists.

   -  in

      A place, where entity already exists.

   -  function

      A name of the function in context of which entity already exists.

::


   FlowPDF::Exception::EntityAlreadyExists->new({
       entity => 'key email',
       in => 'users array',
       function => 'newUser'
   })->throw();


