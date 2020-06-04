# NAME

FlowPDF::Component::EF::Reporting::Dataset

# AUTHOR

CloudBees

# DESCRIPTION

A dataset object.

# METHODS

## getReportObjectTypes()

### Description

Returns a report object types for current dataset.

### Parameters

- None

### Returns

- (ARRAY ref) Report object types for current dataset

### Exceptions

- None

### Usage

```perl

    my $reportObjectTypes = $dataset->getReportObjectTypes();

```

## getData()

### Description

Returns an ARRAY ref with data objects for current dataset.

### Parameters

- None

### Returns

- (ARRAY ref of [FlowPDF::Component::EF::Reporting::Data](/doc/md/FlowPDF/Component/EF/Reporting/Data.md)) An array reference of Data object for the current Dataset object.

### Exceptions

- None

### Usage

```perl

    my $data = $dataset->getData();

```

## newData($params)

### Description

Creates a new data object and adds it to the current dataset and returns a reference for it.

### Parameters

A hash reference with following fields

- (Required)(String) reportObjectType: a report object type for the current data
- (Optional)(HASH ref) values: a values from which data object will be created.

### Returns

- ([FlowPDF::Component::EF::Reporting::Data](/doc/md/FlowPDF/Component/EF/Reporting/Data.md)) A reference to newly created data.

### Exceptions

- Fatal error if required fields are missing.

### Usage

```perl

    my $data = $dataset->newData({
        reportObjectType => 'build',
        values => {
            buildNumber => '2',
            status => 'success',
        }
    });

```