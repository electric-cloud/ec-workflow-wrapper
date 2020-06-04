# NAME

FlowPDF::Helpers

# AUTHOR

CloudBees

# DESCRIPTION

This module provides various static helper functions.

To use them one should explicitly import them.

# METHODS

## trim

### Description

### Parameters

### Usage

```perl

    $str = trim(' hello world ');

```

## isWin

### Description

Returns true if we're running on windows system.

### Parameters

- None

### Returns

- (Integer) 1 if FlowPDF is running on windows, 0 otherwise.

### Exceptions

- None

### Usage

```perl

    if (isWin()) {
        print "This feature is not supported under windows.\n";
    }

```

## genRandomNumbers

### Description

Generates random numbers using an integer as base. If nothing is passed, 99 will be used as base.

### Parameters

- (Optional)(Integer) - an integer value to be used for random number generation. Can be any integer.

### Returns

- (Integer) A random integer value.

### Exceptions

- None

## bailOut

### Description

Immediately aborts current execution and exits with exit code 1.

This exception can't be handled or catched.

### Parameters

- (Required)(String) An error message to be shown before exiting.

### Returns and Exceptions

- None (this call is fatal).

### Usage

```perl

    bailOut("Something is very wrong");

```

## inArray

### Description

Returns 1 if element is present in array. Currently it works only with scalar elements.

### Parameters

- (Required)(Scalar) Element to check it's presence in array.
- (Required)(Array of scalars) An array of elements where element presence should be checked.

### Returns

- (Scalar) 1 if element is found in array and 0 if not.

### Exceptions

- Missing parameters exception.

### Usage

```perl

    my $elem = 'two';
    my @array = ('one', 'two', 'three');
    if (inArray($elem, @array)) {
        print "$elem is present in array\n";
    }

```