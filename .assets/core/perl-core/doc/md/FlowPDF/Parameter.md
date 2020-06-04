# NAME

FlowPDF::Parameter

# AUTHOR

CloudBees

# DESCRIPTION

This class represents ElectricFlow parameters. It could be:

- **Configuration Parameters**
- **Procedure Parameters**

# SYNOPSIS

Objects of this class have support of toString(). If this object will be used in a string context like:

```perl

    my $parameter = $stepParameters->getParameter('query');
    print "Parameter: $parameter\n";

```

getValue() method will be applied automatically and you will get a value instead of reference address.

This object is being returned by [FlowPDF::Config](/doc/md/FlowPDF/Config.md) or [FlowPDF::StepParameters](/doc/md/FlowPDF/Config.md) getParameter() method.

[FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md) object is being returned by getStepParameters() method of [FlowPDF::Context](/doc/md/FlowPDF/StepParameters.md).

[FlowPDF::Config](/doc/md/FlowPDF/Config.md) object is being returned by getConfigValues method of [FlowPDF::Context](/doc/md/FlowPDF/Config.md)

# METHODS

## getName()

### Description

Gets a name from FlowPDF::Parameter object.

### Parameters

- None

### Returns

- (String) Name of the parameter.

### Usage

```perl

    my $parameterName = $parameter->getName();

```

## getValue()

### Description

Returns a value of the current parameter.

### Parameters

- None

### Returns

- (String) Value of the parameter

### Usage

```perl

    my $parameterValue = $parameter->getValue();

```

Also, note, that **this method is being applied by default, if FlowPDF::Parameter object is being used in string context**:

```perl

    # getValue is being applied automatically in string conext. Following 2 lines of code are doing the same:
    print "Query: $query\n";
    printf "Query: %s\n", $query->getValue();

%%LANG

## setName($name)

### Description

Sets a name for the current parameter.

### Parameters

- (Required) (String) Parameter Name

### Returns

- (FlowPDF::Parameter) self

### Usage

```perl

    $parameter->setName('myNewName');

```

## setValue($value)

### Description

### Parameters

- (Required)(String) Parameter Value

### Returns

- (FlowPDF::Parameter) self

### Usage

```perl

    $parameter->setValue('MyNewValue');

```