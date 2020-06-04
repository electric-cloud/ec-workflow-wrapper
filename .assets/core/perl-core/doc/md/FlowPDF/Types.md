# NAME

FlowPDF::Types

# AUTHOR

CloudBees

# DESCRIPTION

This module provides type validation system for FlowPDF. This module is intended to be used by FlowPDF developers.

Each type has a method called match and describe. Match should accept a value that should be validated,
describe() returns a string with current object description, to be used, for example, as error message.

# TYPES

## FlowPDF::Types::Any

This type represents an any value.

```perl

    my $any = FlowPDF::Types::Any();
    if ($any->match('any value') {
        print "Match!\n"
    }
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

```

## FlowPDF::Types::ArrayrefOf

This type represents an array reference with other types as references.
For example, to check that you have an array reference of hashes.

```perl

    my $arrayref = FlowPDF::Types::ArrayrefOf(FlowPDF::Types::Reference('HASH'));
    my $records = [
        {one => 'two'},
        {one => 'two'},
    ];
    if ($arrayref->match($records)) {
        print "Match!\n";
    }
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

```

## FlowPDF::Types::Enum

This type is designed for pre-defined scalar values. For example, procedure context that could be one of: 'procedure', 'schedule', 'pipeline'.

```perl

    my $enum = FlowPDF::Types::Enum('procedure', 'schedule', 'pipeline');
    my $value = 'pipeline';
    if ($enum->match($value)) {
        print "Match!\n";
    }
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

```

## FlowPDF::Types::Scalar

This type represents a scalar string value. It could check that value is just scalar, or a scalar with special value.

```perl

    my $scalar1 = FlowPDF::Types::Scalar('foo');
    my $scalar2 = FlowPDF::Types::Scalar();
    if ($scalar1->match('bar') {
        print "Match!\n"
    }
    # will no match now because scalar with exact value is expected for $scalar1 validator.
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

    # scalar2 will match any scalar, because it was created without value
    if ($scalar2->match('bar') {
        print "Match!\n"
    }

```

## FlowPDF::Types::Reference

This type is for references. If you need to check object or any reference. May accept multiple references.

```

    my $ref = FlowPDF::Types::Reference('HASH', 'ElectricCommander');
    if ($ref->match({})) {
        print "Match!\n";
    }
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

```

## FlowPDF::Types::Regexp

This type represents regexp and validates strings.

```perl

    my $reg = FlowPDF::Types::Regexp(qr/^[A-Z]+$/, qr/^[a-z]+$/);
    if ($reg->match("ASDF")) {
        print "Match!\n";
    }
    else {
        print "No match: ", $arrayref->describe(), "\n";
    }

```