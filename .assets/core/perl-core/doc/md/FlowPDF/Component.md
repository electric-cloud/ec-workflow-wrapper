# NAME

FlowPDF::Component

# AUTHOR

CloudBees

# DESCRIPTION

This module provides a base class for FlowPDF Components.

Each FlowPDF Component is a perl module which should have init($initParams) method and be a subclass of FlowPDF::Component.

# USAGE

To create a component one should define a class that inherits this class and define an init($class, $params) method to make it working.
Also, components should be loading using [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md), please, avoid direct usage of components modules.

Direct usage of components will be prohibited in the next release.

Example of a simple component:

```perl

    package FlowPDF::Component::MyComponent
    use base qw/FlowPDF::Component/;
    use strict;
    use warnings;

    sub init {
        my ($class, $initParams) = @_;
            my ($initParams) = @_;
            my $retval = {%$initParams};
            bless $retval, $class;
            return $retval;
    }

    sub action {
        my ($self) = @_;
        print "Doing Action!";
    }

```

Then, to load this component using [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md) one should use its loadComponent method.

Please, note, that loadComponent loads component globally, that is, you don't need to do loadComponent with parameters again and again.

You need to call getComponent('FlowPDF::Component::YourComponent') of [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md).

Please, note, that in that case getComponent() will return exactly the same object that was created during component loading.

To get more details about component loading see [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md)

Example:

```perl

    my $component = FlowPDF::ComponentManager->loadComponent('FlowPDF::Component::MyComponent', $initParams);
    # then you can use your component across your code.
    # to do that, you need to get this component from anywere in current runtime.
    ...;
    sub mySub {
        # the same component object.
        my $component = FlowPDF::ComponentManager->getComponent('FlowPDF::Component::MyComponent');
    }

```

# AVAILABLE COMPONENTS

Currently there are 3 components that are going with [FlowPDF](/doc/md/FlowPDF.md):

- [FlowPDF::Component::Proxy](/doc/md/FlowPDF/Component/Proxy.md)
- [FlowPDF::Component::CLI](/doc/md/FlowPDF/Component/CLI.md)
- [FlowPDF::Component::OAuth](/doc/md/FlowPDF/Component/OAuth.md)