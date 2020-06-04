NAME
====

FlowPDF::Devel::Stacktrace

AUTHOR
======

CloudBees

DESCRIPTION
===========

This module provides a stack trace functionality for FlowPDF.

It creates a stack trace which could be stored as object and then used
in a various situations.

METHODS
=======

new
---

.. _description-1:

Description
-----------

Creates new FlowPDF::Devel::Stacktrace object and stores stacktrace on
the time of creation. It means, that this object should be created right
before it should be used if goal is to get current stacktrace. Just
note, that this call stores stacktrace on the moment of creation.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (FlowPDF::Devel::Stacktrace) A stack trace on the moment of
   invocation.

Exceptions
~~~~~~~~~~

-  None

Usage
~~~~~

.. code:: perl


       my $st = FlowPDF::Devel::Stacktrace->new();

toString
--------

.. _description-2:

Description
-----------

Converts a FlowPDF::Devel::StackTrace object into printable string.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

.. _returns-1:

Returns
~~~~~~~

-  (String) A printable stack trace.

.. _exceptions-1:

Exceptions
~~~~~~~~~~

-  None

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $st = FlowPDF::Devel::Stacktrace->new();
       print $st->toString();

clone
-----

.. _description-3:

Description
-----------

This function clones an existing FlowPDF::Devel::Stacktrace and returns
new FlowPDF::Devel::Stacktrace reference that points to different
FlowPDF::Devel::Stacktrace object.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  None

.. _returns-2:

Returns
~~~~~~~

-  (FlowPDF::Devel::Stacktrace) A clone of caller object.

.. _exceptions-2:

Exceptions
~~~~~~~~~~

-  None

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $st = FlowPDF::Devel::Stacktrace->new();
       my $st2 = $st->clone();


