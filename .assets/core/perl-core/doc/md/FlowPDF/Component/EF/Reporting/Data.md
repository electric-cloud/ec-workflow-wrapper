# NAME

FlowPDF::Component::EF::Reporting::Data

# AUTHOR

CloudBees

# DESCRIPTION

A data object.

# METHODS

## getReportObjectType()

### Description

Returns a report object type for current data.

### Parameters

- None

### Returns

- (String) Report object type for current data.

### Exceptions

- None

### Usage

```perl

    my $reportObhectType = $data->getReportObjectType();

```

## getValues()

### Description

Returns a values for the current data.

### Parameters

- None

### Returns

- (HASH ref) A values for the current data.

### Usage

```perl

    my $values = $data->getValues();

```

## addOrUpdateValue

### Description

Adds or updates a value for the current data object.

### Parameters

- (Required)(String) Key for the data.
- (Required)(String) Value for the data.

### Returns

- Reference to the current FlowPDF::Component::EF::Reporting::Data

### Exceptions

- None

### Usage

```perl

    $data->addOrUpdateValue('key', 'value')

```

## addValue

### Description

Adds a new value to the data values, falls with exceptions if provided key already exists.

### Parameters

- (Required)(String) Key for the data.
- (Required)(String) Value for the data.

### Returns

- Reference to the current FlowPDF::Component::EF::Reporting::Data

### Exceptions

- Fatal error if field already exists.

### Usage

```perl

    $data->addValue('key', 'value')

```

## updateValue

### Description

Updates a value for current data values. Fatal error if value does not exist.

### Parameters

- (Required)(String) Key for the data.
- (Required)(String) Value for the data.

### Returns

- Reference to the current FlowPDF::Component::EF::Reporting::Data

### Exceptions

- Fatal exception if value does not exist.

### Usage

```perl

    $data->updateValue('key', 'value')

```