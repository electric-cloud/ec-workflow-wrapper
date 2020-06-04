DEPRECATION NOTE
================

This class has been deprecated and
`FlowPDF::BaseClass2 <flowpdf-perl-lib/FlowPDF/BaseClass2.html>`__ should be used
instead.

This class works aroung perl AUTOLOAD mechanism, which is extremely hard
to debug.

NAME
====

FlowPDF::BaseClass

AUTHOR
======

CloudBees

DESCRIPTION
===========

FlowPDF::BaseClass is the base class for the classes across FlowPDF SDK.

This class creates in runtime accessors for class properties and creates
a new() method as constructor.

This class was designed for internal usage for developers of FlowPDF
Perl SDK.

USAGE
=====

To use base class one need to:

-  Create a class
-  Make this class as base using use base
-  Create classDefinition() method which returns a hashref with class
   definition.

.. _usage-1:

USAGE
=====

.. code:: perl


       package MyClass;
       use base qw/FlowPDF::BaseClass/;
       use strict;
       sub classDefinition {
           return {
               name => 'str',
               value => 'str'
           };
       }

       1;

After this class has been created, you can use it and have an
accessors/constructors.

.. code:: perl


       use MyClass;
       my $object = MyClass->new({name => 'one', value => 'two'});
       # name = one
       my $name = $object->getName();
       # value = two
       my $value = $object->getValue();


