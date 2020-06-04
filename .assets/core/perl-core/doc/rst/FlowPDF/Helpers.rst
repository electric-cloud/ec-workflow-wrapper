NAME
====

FlowPDF::Helpers

AUTHOR
======

CloudBees

DESCRIPTION
===========

This module provides various static helper functions.

To use them one should explicitly import them.

METHODS
=======

trim
----

.. _description-1:

Description
~~~~~~~~~~~

Parameters
~~~~~~~~~~

Usage
~~~~~

.. code:: perl


       $str = trim(' hello world ');

isWin
-----

.. _description-2:

Description
~~~~~~~~~~~

Returns true if we're running on windows system.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  (Integer) 1 if FlowPDF is running on windows, 0 otherwise.

Exceptions
~~~~~~~~~~

-  None

.. _usage-1:

Usage
~~~~~

.. code:: perl


       if (isWin()) {
           print "This feature is not supported under windows.\n";
       }

genRandomNumbers
----------------

.. _description-3:

Description
~~~~~~~~~~~

Generates random numbers using an integer as base. If nothing is passed,
99 will be used as base.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Optional)(Integer) - an integer value to be used for random number
   generation. Can be any integer.

.. _returns-1:

Returns
~~~~~~~

-  (Integer) A random integer value.

.. _exceptions-1:

Exceptions
~~~~~~~~~~

-  None

bailOut
-------

.. _description-4:

Description
~~~~~~~~~~~

Immediately aborts current execution and exits with exit code 1.

This exception can't be handled or catched.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (Required)(String) An error message to be shown before exiting.

Returns and Exceptions
~~~~~~~~~~~~~~~~~~~~~~

-  None (this call is fatal).

.. _usage-2:

Usage
~~~~~

.. code:: perl


       bailOut("Something is very wrong");

inArray
-------

.. _description-5:

Description
~~~~~~~~~~~

Returns 1 if element is present in array. Currently it works only with
scalar elements.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  (Required)(Scalar) Element to check it's presence in array.
-  (Required)(Array of scalars) An array of elements where element
   presence should be checked.

.. _returns-2:

Returns
~~~~~~~

-  (Scalar) 1 if element is found in array and 0 if not.

.. _exceptions-2:

Exceptions
~~~~~~~~~~

-  Missing parameters exception.

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $elem = 'two';
       my @array = ('one', 'two', 'three');
       if (inArray($elem, @array)) {
           print "$elem is present in array\n";
       }


