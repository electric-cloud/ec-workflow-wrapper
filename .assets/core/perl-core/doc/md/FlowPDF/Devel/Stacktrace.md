# NAME

FlowPDF::Devel::Stacktrace

# AUTHOR

CloudBees

# DESCRIPTION

This module provides a stack trace functionality for FlowPDF.

It creates a stack trace which could be stored as object and then used in a various situations.

# METHODS

## new

## Description

Creates new FlowPDF::Devel::Stacktrace object and stores stacktrace on the time of creation.
It means, that this object should be created right before it should be used if goal is to get current stacktrace.
Just note, that this call stores stacktrace on the moment of creation.

### Parameters

- None

### Returns

- (FlowPDF::Devel::Stacktrace) A stack trace on the moment of invocation.

### Exceptions

- None

### Usage

```perl

    my $st = FlowPDF::Devel::Stacktrace->new();

```

## toString

## Description

Converts a FlowPDF::Devel::StackTrace object into printable string.

### Parameters

- None

### Returns

- (String) A printable stack trace.

### Exceptions

- None

### Usage

```perl

    my $st = FlowPDF::Devel::Stacktrace->new();
    print $st->toString();

```

## clone

## Description

This function clones an existing FlowPDF::Devel::Stacktrace and returns new FlowPDF::Devel::Stacktrace reference that points to different FlowPDF::Devel::Stacktrace object.

### Parameters

- None

### Returns

- (FlowPDF::Devel::Stacktrace) A clone of caller object.

### Exceptions

- None

### Usage

```perl

    my $st = FlowPDF::Devel::Stacktrace->new();
    my $st2 = $st->clone();

```