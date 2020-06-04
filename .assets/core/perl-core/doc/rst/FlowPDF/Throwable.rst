NAME
====

FlowPDF::Throwable

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class provides a low-level base class for exceptions that is being
used in FlowPDF development.

If you're a framework developer and know what are you doing, use this
class. If you're looking for a base class for custom Exceptions, visit
`FlowPDF::Exception <flowpdf-perl-lib/FlowPDF/Exception.html>`__.

**Important note**

This class and inherited classes have automatic toString call in the
scalar context. It has been done to allow exceptions be used with
regular croak or die function in the scalar context.

METHODS
~~~~~~~

This class provides following getters and setters:

-  new($hashref)

   Constructor. Accepts hash reference that may have fields: callInfo,
   message and code.

-  getMessage()

-  setMessage($str)

-  getCode()

-  setCode($str)

-  getCallInfo()

-  setCallInfo($str)

-  throw()

   This function throws an exception.

-  toString()

   Converts a throwable object into string. Automatically being applied
   in the scalar context.

-  is($reference)

   Returns a true if $reference has the same reference as current
   throwable object. It is done for simplification of exception
   handling. For example:

   .. code:: perl


      try {
          $exception->throw();
      } catch {
          my ($e) = @\_;
          if ($e->is('CustomException1')) {
              ...;
          }
          elsif ($e->is('CustomException2')) {
              ...;
          }
      }
