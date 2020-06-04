# NAME

FlowPDF::Component::EF::Reporting::Payloadset

# AUTHOR

CloudBees

# DESCRIPTION

A payloadset object.

# METHODS

## getReportObjectTypes()

### Description

Returns an array reference of string report object types for current set of payloads

### Parameters

- None

### Returns

- (ARRAY ref) Report object types

### Exceptions

- None

### Usage

```perl

    my $reportObjectTypes = $payloadSet->getReportObjectTypes();

```

## getPayloads()

### Description

Returns an array references to the payloads.

### Parameters

- None

### Returns

- (ARRAY ref) of [FlowPDF::Component::EF::Reporting::Payload](/doc/md/FlowPDF/Component/EF/Reporting/Payload.md)

### Exceptions

- None

### Usage

```perl

    my $payloads = $payloadset->getPayloads();

```

## newPayload($params)

### Description

Creates a new payload and adds it to current payload set and returns a reference for it.

### Parameters

A hash reference with following fields

- (Required)(String) reportObjectType: a report object type for the current payload
- (Optional)(HASH ref) values: a values that will be send to the Devops Insight Center. An actual payload.

### Returns

- ([FlowPDF::Component::EF::Reporting::Payload](/doc/md/FlowPDF/Component/EF/Reporting/Payload.md)) A reference to newly created payload.

### Exceptions

- Fatal error if required fields are missing.

### Usage

```perl

    my $payload = $payloadSet->newPayload({
        reportObjectType => 'build',
        values => {
            buildNumber => '2',
            status => 'success',
        }
    });

```

## newPayload($params)

### Description

Returns an array reference of string report object types for current set of payloads

### Parameters

A hash reference with following fields

- (Required)(String) reportObjectType: a report object type for the current payload
- (Optional)(HASH ref) values: a values that will be send to the Devops Insight Center. An actual payload.

### Returns

- ([FlowPDF::Component::EF::Reporting::Payload](/doc/md/FlowPDF/Component/EF/Reporting/Payload.md)) A reference to newly created payload.

### Exceptions

- Fatal error if required fields are missing.

### Usage

```perl

    my $payload = $payloadSet->newPayload({
        reportObjectType => 'build',
        values => {
            buildNumber => '2',
            status => 'success',
        }
    });

```

## getLastPayload()

### Description

Returns the last payload from current Payloadset.

### Parameters

- None

### Returns

- ([FlowPDF::Component::EF::Reporting::Payload](/doc/md/FlowPDF/Component/EF/Reporting/Payload.md)) A reference to the last payload.

### Exceptions

- None

### Usage

```perl

    my $lastPayload = $payloadSet->getLastPayload();

```