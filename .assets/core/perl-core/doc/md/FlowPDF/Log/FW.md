# NAME

FlowPDF::Log::FW

# AUTHOR

CloudBees

# NOTE

This module is not intented to be used by plugin developers. This module should be used only by FlowPDF developers.

# DESCRIPTION

This module provides a log for the FlowPDF itself and should be imported and used only in FlowPDF libraries.

**This module should not be used as logger for business-logic code. This is logger for framework itself.**

The logger that you're looking for is [FlowPDF::Log](/doc/md/FlowPDF/Log.md).

Also, please, note, that FlowPDF::Log::FW is a singleton. This object is automatically created during module import.

Just write:

```perl

use FlowPWDF::Log::FW;

```

And now you have an already created and available logger.

# SPECIAL ENVIRONMENT VARIABLES AND METHODS

This module reacts on the following environment variables:

- FLOWPDF\_FW\_LOG\_TO\_FILE

    An absolute of wile where log will be written. If file could not be written, logging to the file will be disabled automatically
    and warning will be shown in the logs.

- FLOWPDF\_FW\_LOG\_TO\_PROPERTY

    A property path where log will be written.

- FLOWPDF\_FW\_LOG\_LEVEL

    A log level of logger. One of:

    - 0 - INFO
    - 1 - DEBUG
    - 2 - TRACE

    Default is INFO.

And following methods:

- setLogLevel();
- getLogLevel();
- setLogToProperty();
- getLogProperty();
- setLogToFile();
- getLogFile();

Please, note, that these logfile writing methods are not exclusive. It means that logger will write to all destination that are available.

For example, if log to property is enabled alongside with logging to file, log will be written to the property and to the file.

# LOGGING METHODS

- fwLogInfo
- fwLogDebug
- fwLogTrace
- fwLogError
- fwLogWarning