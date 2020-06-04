# NAME

FlowPDF::ComponentManager

# AUTHOR

CloudBees

# DESCRIPTION

FlowPDF::ComponentManager is a class that provides you an access to FlowPDF Components infrastructure.

This class allows you to load components depending on you needs.

Currently, there are 2 components loading strategies supported.

- **Local**

    Local component is being loaded to current FlowPDF::ComponentManager object context.

    So, it is only possible to access it from current object.

- **Global**

    This is default strategy, component is being loaded for whole execution context and could be accessed from any FlowPDF::ComponentManager object.

# METHODS

## new()

### Description

This method creates a new FlowPDF::ComponentManager object. It doesn't have parameters.

### Parameters

- None

### Returns

- FlowPDF::ComponentManager

### Usage

```perl

    my $componentManager = FlowPDF::ComponentManager->new();

```

## loadComponentLocal($componentName, $initParams)

### Description

Loads, initializes the component and returns its as FlowPDF::Component:: object in context of current FlowPDF::ComponentManager object.

### Parameters

- (Required)(String) A name of the component to be loaded
- (Required)(HASH ref) An init parameters for the component.

### Returns

- FlowPDF::Component:: object

### Usage

```perl

    $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

```

Accepts as parameters component name and initialization values. For details about initialization values see [FlowPDF::Component](/doc/md/FlowPDF/Component.md)

## loadComponent($componentName, $initParams)

### Description

Loads, initializes the component and returns its as FlowPDF::Component:: object in global context.

### Parameters

- (Required)(String) A name of the component to be loaded
- (Required)(HASH ref) An init parameters for the component.

### Returns

- FlowPDF::Component:: object

### Usage

```perl

    $componentManager->loadComponentLocal('FlowPDF::Component::YourComponent', {one => two});

```

Accepts as parameters component name and initialization values. For details about initialization values see [FlowPDF::Component](/doc/md/FlowPDF/Component.md)

## getComponent($componentName)

### Description

Returns an FlowPDF::Component object that was previously loaded globally. For local context see getComponentLocal.

### Parameters

- (Required)(String) Component to get from global context.

### Returns

- FlowPDF::Component:: object

### Usage

```perl

    my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');

```

## getComponentLocal($componentName)

### Description

Returns an FlowPDF::Component object that was previously loaded in local context.

### Parameters

- (Required)(String) Component to get from local context.

### Returns

- FlowPDF::Component:: object

### Usage

```perl

    my $component = $componentManager->getComponent('FlowPDF::Component::Proxy');

```