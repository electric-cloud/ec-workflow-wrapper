# NAME

FlowPDF::Config

# AUTHOR

CloudBees

# DESCRIPTION

This class represents values of current configuration (global values) that is available in current run context by the name that is provided in procedure config form.

# SYNOPSIS

To get an FlowPDF::Config object you need to use getConfigValues() method from [FlowPDF::Context](/doc/md/FlowPDF/Context.md).

# METHODS

## isParameterExists()

### Description

Returns true if parameter exists in the current configuration.

### Parameters

- None

### Returns

- (Boolean) True if parameter exists.

### Usage

```perl

    if ($configValues->isParameterExists('endpoint')) {
        ...;
    }

```

## getParameter($parameterName)

### Description

Returns an [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object or [FlowPDF::Credential](/doc/md/FlowPDF/Parameter.md) object.

### Parameter

- (String) Name of parameter to get.

### Returns

- ([FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md)|[FlowPDF::Credential](/doc/md/FlowPDF/Parameter.md)) Parameter or credential by it's name

### Usage

To get parameter object:

```perl

    my $query = $configValues->getParameter('query');

```

If your parameter is an [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object, you can get its value either by getValue() method, or using string context:

```perl

    print "Query:", $query->getValue();

```

Or:

```perl

    print "Query: $query"

```

If your parameter is [FlowPDF::Credential](/doc/md/FlowPDF/Credential.md), follow its own documentation.

## getRequiredParameter($parameterName)

### Description

Returns an [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object or [FlowPDF::Credential](/doc/md/FlowPDF/Parameter.md) object if this parameter exists.

If parameter does not exist, this method aborts execution with exit code 1.

This exception can't be catched.

### Parameters

- (String) Name of parameter to get.

### Returns

- ([FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md)|[FlowPDF::Credential](/doc/md/FlowPDF/Parameter.md)) Parameter or credential by it's name

### Usage

To get parameter object:

```perl

    my $query = $configValues->getRequiredParameter('endpoint');

```

If your parameter is an [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object, you can get its value either by getValue() method, or using string context:

```perl

    print "Query:", $query->getValue();

```

Or:

```perl

    print "Query: $query"

```

If your parameter is [FlowPDF::Credential](/doc/md/FlowPDF/Credential.md), follow its own documentation.

## asHashref()

### Description

This function returns a HASH reference that is made from FlowPDF::Config object.
Where key is a name of parameter and value is a value of parameter.

For credentials the same pattern as for getConfigValue() from [FlowPDF::Context](/doc/md/FlowPDF/Context.md) is being followed.

### Parameters

- None

### Returns

- (HASH reference) A HASH reference to a HASH with config values.

### Exceptions

- None

### Usage

```perl

    my $config = $context->getConfigValues()->asHashref();
    logInfo("Endpoint is: $config->{endpoint}");

```