# NAME

FlowPDF::Component::EF::Reporting::Payload

# AUTHOR

CloudBees

# DESCRIPTION

A payload object.

# METHODS

## getReportObjectType()

### Description

Returns a report object type for current payload.

### Parameters

- None

### Returns

- (String) Report object type for current payload

### Exceptions

- None

### Usage

```perl

    my $reportObhectType = $payload->getReportObjectType();

```

## getValues()

### Description

Returns a values that will be sent for the current payload.

### Parameters

- None

### Returns

- (HASH ref) A values for the current payload to be sent.

### Usage

```perl

    my $values = $payload->getValues();

```

## getDependentPayloads()

### Note

**This method still experimental**

### Description

This method returns a dependent payloads for the current payload.

This method may be used when there is more than one report object type should be send in the context of a single payload.

### Parameters

- None

### Returns

- (ARRAY ref of FlowPDF::Component::EF::Reporting::Payload)

### Exceptions

### Usage

```perl

    my $payloads = $payload->getDependentPayloads();

```