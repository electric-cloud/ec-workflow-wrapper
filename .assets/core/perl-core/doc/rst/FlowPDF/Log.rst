NAME
====

FlowPDF::Log

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class provides logging functionality for FlowPDF.

CAVEATS
=======

This package is being loaded at the beginning of FlowPDF execution
behind the scene.

It is required to set up logging before other components are
initialized.

Logger is retrieving through run context current debug level from
configuration.

To enable this mechanics you need to add **debugLevel** property to your
configuration.

It will be automatically read and logger would already have this debug
level.

Supported debug levels:

-  **INFO**

   Provides standard output. This is default level.

   debugLevel property should be set to 0.

-  **DEBUG**

   Provides the same output from INFO level + debug output.

   debugLevel property should be set to 1.

-  **TRACE**

   Provides the same output from DEBUG level + TRACE output.

   debugLevel property should be set to 2.

SYNOPSIS
========

To import FlowPDF::Log:

.. code:: perl


       use FlowPDF::Log

METHODS
=======

This package imports following functions on load into current scope:

logInfo(@messages)
------------------

.. _description-1:

Description
~~~~~~~~~~~

Logs an info message. Output is the same as from print function.

Parameters
~~~~~~~~~~

-  (List of String) Log messages

Returns
~~~~~~~

-  (Boolean) 1

Usage
~~~~~

.. code:: perl


       logInfo("This is an info message");

logDebug(@messages)
-------------------

.. _description-2:

Description
~~~~~~~~~~~

Logs a debug message.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (List of String) Log messages

.. _returns-1:

Returns
~~~~~~~

-  (Boolean) 1

.. _usage-1:

Usage
~~~~~

.. code:: perl


       # this will print [DEBUG] This is a debug message.
       # but only if debug level is enough (DEBUG or more).
       logDebug("This is a debug message");

logTrace(@messages)
-------------------

.. _description-3:

Description
~~~~~~~~~~~

Logs a trace message

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (List of String) Log messages

.. _returns-2:

Returns
~~~~~~~

-  (Boolean) 1

.. _usage-2:

Usage
~~~~~

.. code:: perl


       # this will print [TRACE] This is a trace message.
       # but only if debug level is enough (TRACE or more).
       logTrace("This is a debug message");

logWarning(@messages)
---------------------

.. _description-4:

Description
~~~~~~~~~~~

Logs a warning message.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (List of String) Log messages

.. _returns-3:

Returns
~~~~~~~

-  (Boolean) 1

.. _usage-3:

Usage
~~~~~

.. code:: perl

       # this will print [WARNING] This is a warning message for any debug level:
       logWarning("This is a warning message");

logError(@messages)
-------------------

.. _description-5:

Description
~~~~~~~~~~~

Logs an error message

.. _parameters-4:

Parameters
~~~~~~~~~~

-  (List of String) Log messages

.. _returns-4:

Returns
~~~~~~~

-  (Boolean) 1

.. _usage-4:

Usage
~~~~~

.. code:: perl


       # this will print [ERROR] This is an error message for any debug level:
       logError("This is an error message");

logInfoDiag
-----------

This function works exactly as logInfo, but adds additional markups into
log. Then this info will be displayed at Diagnostic tab of a job.

logWarningDiag
--------------

This function works exactly as logWarning, but adds additional markups
into log. Then this warning will be displayed at Diagnostic tab of a
job.

logErrorDiag
------------

This function works exactly as logError, but adds additional markups
into log. Then this error will be displayed at Diagnostic tab of a job.
