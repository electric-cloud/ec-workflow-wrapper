NAME
====

FlowPDF::Client::REST

AUTHOR
======

CloudBees

DESCRIPTION
===========

This module provides a simple rest client for various HTTP interactions.
It has been designed to be as closest as possible to HTTP::Request and
LWP::UserAgent object methods.

USAGE
=====

You can get FlowPDF::Client::REST object using regular constructor:
new(), or through `FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__
object, using newRESTClient() methods.

Retrieving FlowPDF::Client::REST object from
`FlowPDF::Context <flowpdf-perl-lib/FlowPDF/Context.html>`__ is preferred, because
during retrieval from context, some components may be applied
automatically to FlowPDF::Client::REST object, like proxy and
`FlowPDF::Log <flowpdf-perl-lib/FlowPDF/Log.html>`__.

.. code:: perl


       sub stepGetContent {
           my ($pluginObject) = @_;

           # retrieving context object
           my $context = $pluginObject->getContext();
           # creating new FlowPDF::Client::REST object
           my $rest = $context->newRESTClient();
           # creatung new HTTP::Request object using FlowPDF APIs
           my $request = $rest->newRequest(GET => 'http://electric-cloud.com');
           # performing request and getting HTTP::Response object.
           my $response = $rest->doRequest($request);
           # printing response content
           print "Content: ", $response->decoded_content();
       }

METHODS
=======

new($parameters)
----------------

.. _description-1:

Description
~~~~~~~~~~~

Constructor. Creates new FlowPDF::Client::REST object.

It has internal support of
`FlowPDF::Component::Proxy <flowpdf-perl-lib/FlowPDF/Component/Proxy.html>`__.

To use FlowPDF::Client::REST with proxy you need to provide a proxy
parameters to constructor. They are:

-  **url**

   An address of the proxy to be used as http proxy.

-  **username**

   The username that is being used for proxy authorization.

-  **password**

   The password that is being used for username for proxy authorization.

-  **debug**

   Debug enabling switch. Debug output for FlowPDF::Proxy will be
   enabled if this is passed as true.

Parameters
~~~~~~~~~~

-  (Optional)(HASH ref) A parameters that are required to get additional
   things from FlowPDF::Client::REST. Details above.

Returns
~~~~~~~

-  FlowPDF::Client::REST

.. _usage-1:

Usage
~~~~~

.. code:: perl


           my $rest = FlowPDF::Client::REST->new({
               proxy => {
                   url => 'http://squid:3128',
                   username => 'user1',
                   password => 'user2'
               }
           });

In that example FlowPDF::Rest loads automatically
`FlowPDF::Component::Proxy <flowpdf-perl-lib/FlowPDF/Component/Proxy.html>`__ and
creates new FlowPDF::Client::REST.

newRequest(@parameters)
-----------------------

Creates new HTTP::Request object.

This wrapper has been created to implement request augmenations using
components during request object creation.

For example, if FlowPDF::Client::Rest has been created with proxy
support, it will return HTTP::Request object with applied proxy fields.

This method has the same interface and usage as as HTTP::Request::new();

.. _parameters-1:

Parameters
~~~~~~~~~~

-  HTTP::Request::new() parameters.

.. _returns-1:

Returns
~~~~~~~

-  HTTP::Request

.. _usage-2:

Usage
~~~~~

.. code:: perl


       my $request = $rest->newRequest(GET => 'https://electric-cloud.com');

doRequest($httpRequest)
-----------------------

.. _description-2:

Description
~~~~~~~~~~~

Performs HTTP request, using HTTP::Request object as parameter.

Also, this method supports API of LWP::UserAgent::request() method.

This method returns HTTP::Response object.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  LWP::UserAgent::request() parameters

.. _returns-2:

Returns
~~~~~~~

-  HTTP::Response

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $request = $rest->newRequest(GET => 'https://electric-cloud.com');
       my $response = $rest->doRequest($request);
       print $response->decoded_content();

augmentUrlWithParams($url, $arguments)
--------------------------------------

.. _description-3:

Description
~~~~~~~~~~~

Helper method, that provides a mechanism for adding query parameters to
URL, with proper escaping.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (Required)(String) Url that should be augmented with query
   parameters.
-  (Required)(HASH ref) hash of parameters to be escaped and added to
   the query string.

.. _returns-3:

Returns
~~~~~~~

-  (String) Url with added query parameters.

.. _usage-4:

Usage
~~~~~

.. code:: perl


       my $url = 'http://localhost:8080;

       $url = $rest->augmentUrlWithParams($url, {one=>'two'});
       # url = http://localhost:8080?one=two


