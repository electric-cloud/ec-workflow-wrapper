NAME
====

FlowPDF::ComponentManager

AUTHOR
======

CloudBees

DESCRIPTION
===========

FlowPDF::ComponentManager is a class that provides you an access to
FlowPDF Components infrastructure.

This class allows you to load components depending on you needs.

Currently, there are 2 components loading strategies supported.

-  **Local**

   Local component is being loaded to current FlowPDF::ComponentManager
   object context.

   So, it is only possible to access it from current object.

-  **Global**

   This is default strategy, component is being loaded for whole
   execution context and could be accessed from any
   FlowPDF::ComponentManager object.

METHODS
=======

new()
-----

.. _description-1:

Description
~~~~~~~~~~~

This method creates a new FlowPDF::ComponentManager object. It doesn't
have parameters.

Parameters
~~~~~~~~~~

-  None

Returns
~~~~~~~

-  FlowPDF::ComponentManager

Usage
~~~~~

.. code:: perl


       my $componentManager = FlowPDF::ComponentManager->new();

loadComponentLocal($componentName, $initParams)
-----------------------------------------------

.. _description-2:

Description
~~~~~~~~~~~

Loads, initializes the component and returns its as FlowPDF::Component::
object in context of current FlowPDF::ComponentManager object.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (Required)(String) A name of the component to be loaded
-  (Required)(HASH ref) An init parameters for the component.

.. _returns-1:

Returns
~~~~~~~

-  FlowPDF::Component:: object

.. _usage-1:

Usage
~~~~~

.. code:: perl


       $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

Accepts as parameters component name and initialization values. For
details about initialization values see
`FlowPDF::Component <flowpdf-perl-lib/FlowPDF/Component.html>`__

loadComponent($componentName, $initParams)
------------------------------------------

.. _description-3:

Description
~~~~~~~~~~~

Loads, initializes the component and returns its as FlowPDF::Component::
object in global context.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  (Required)(String) A name of the component to be loaded
-  (Required)(HASH ref) An init parameters for the component.

.. _returns-2:

Returns
~~~~~~~

-  FlowPDF::Component:: object

.. _usage-2:

Usage
~~~~~

.. code:: perl


       $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

Accepts as parameters component name and initialization values. For
details about initialization values see
`FlowPDF::Component <flowpdf-perl-lib/FlowPDF/Component.html>`__

getComponent($componentName)
----------------------------

.. _description-4:

Description
~~~~~~~~~~~

Returns an FlowPDF::Component object that was previously loaded
globally. For local context see getComponentLocal.

.. _parameters-3:

Parameters
~~~~~~~~~~

-  (Required)(String) Component to get from global context.

.. _returns-3:

Returns
~~~~~~~

-  FlowPDF::Component:: object

.. _usage-3:

Usage
~~~~~

.. code:: perl


       my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');

getComponentLocal($componentName)
---------------------------------

.. _description-5:

Description
~~~~~~~~~~~

Returns an FlowPDF::Component object that was previously loaded in local
context.

.. _parameters-4:

Parameters
~~~~~~~~~~

-  (Required)(String) Component to get from local context.

.. _returns-4:

Returns
~~~~~~~

-  FlowPDF::Component:: object

.. _usage-4:

Usage
~~~~~

.. code:: perl


       my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');


