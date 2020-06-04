NAME
====

FlowPDF::BaseClass2;

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class is desined to be the base class for an internal classes of
FlowPDF. Using this class gives following benefits:

-  Automatic generation of constructor.
-  Automatic generation of getters/setters.
-  Types validation for setters/constructors.
-  Inheritance support.

USAGE
=====

To use this class, following 2 conditions should be met.

-  Your class should be inherited from this class.
-  defineClass method should be called.

defineClass method
------------------

defineClass is a method that is being used to generate type checkers,
getters, setters and constructor for your class. This mehod accepts as
single parameter a hash reference with where keys are the field names
and values are types for these fields.

To get information about type validators see
`FlowPDF::Types <flowpdf-perl-lib/FlowPDF/Types.html>`__ documentation.

Also, note that this class was designed with camelCase in mind, so if
you defining field "one" and field twoThree for YourClass, following
getters/setters will be generated alongside with new() function:

-  getOne()
-  setOne()
-  getTwoThree()
-  setTwoThree()

As you see, first letter of field was capitalized, and get/set prepended
to this field name.

Parameters
~~~~~~~~~~

-  (Required)(HASH reference) A hash reference in format field => type.

Example of a class
------------------

Following example demonstrates this approach:

.. code:: perl


       package YourClass;
       use base FlowPDF::BaseClass2;
       use strict;
       use warnings;

       # if you're not a perl expert, __PACKAGE__ is a kinda macro,
       # which is being replaced with package name during compile time.
       # so, __PACKAGE__->method() and YourClass->method() are the same calls.
       __PACKAGE__->defineClass({
           one => FlowPDF::Types::Scalar(),
           two => FlowPDF::Types::Reference('HASH')
       });

       1;

After your class is defined as above, you can use a benefits from this
package.

To create an object of YourClass;

.. code:: perl


       use YourClass;
       my $o = YourClass->new({
           one => 'hello',
           two => {
               three => 'four'
           }
       });

       print $o->getOne();
       $o->setOne('world');
       print $o->getOne(), "\n";


