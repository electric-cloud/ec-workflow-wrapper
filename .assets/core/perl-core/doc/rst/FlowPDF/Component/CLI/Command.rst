NAME
====

FlowPDF::Component::CLI::Command

AUTHOR
======

CloudBees

DESCRIPTION
===========

This class represents a system command that is being used by
`FlowPDF::Component::CLI <flowpdf-perl-lib/FlowPDF/Component/CLI.html>`__.

METHODS
=======

new($shell, @args)
------------------

.. _description-1:

Description
~~~~~~~~~~~

This method returns an FlowPDF::Component::CLI::Command object.

Parameters
~~~~~~~~~~

-  (Required)(String) Command to be executed
-  (Optional)(list of Strings) Arguments to be added to the command.

Returns
~~~~~~~

Usage
~~~~~

.. code:: perl


       my $command = FlowPDF::Component::CLI::Command->new('ls', '-la');

Note
~~~~

It is much better to use newCommand metod from
`FlowPDF::Component::CLI <flowpdf-perl-lib/FlowPDF/Component/CLI.html>`__

addArguments(@args)
-------------------

.. _description-2:

Description
~~~~~~~~~~~

Adds a new arguments to the command.

.. _parameters-1:

Parameters
~~~~~~~~~~

-  (Required)(list of String) arguments to be added

.. _returns-1:

Returns
~~~~~~~

-  FlowPDF::Component::CLI::Command self

.. _usage-1:

Usage
~~~~~

.. code:: perl


       my $command = FlowPDF::Component::CLI->newCommand('ls');
       $command->addArguments('-l', '-a');

renderCommand()
---------------

.. _description-3:

Description
~~~~~~~~~~~

Returns a rendered command with its arguments.

.. _parameters-2:

Parameters
~~~~~~~~~~

-  None

.. _returns-2:

Returns
~~~~~~~

-  (String) Rendered command.
