# NAME

FlowPDF::Exception

# AUTHOR

CloudBees

# DESCRIPTION

A superclass for exceptions in FlowPDF. All out-of-the box exeptions that are provided by FlowPDF are subclasses of this one.

For more details about exceptions and how to use them follow Plugin Developer's Guide.

FlowPDF provides, out of the box, following exceptions:

## List of available out of the box exceptions.

- [FlowPDF::Exception::UnexpectedEmptyValue](/doc/md/FlowPDF/Exception/UnexpectedEmptyValue.md)

    An exception that could be used when something returned an unexpected undef or empty string.

- [FlowPDF::Exception::MissingFunctionDefinition](/doc/md/FlowPDF/Exception/MissingFunctionDefinition.md)

    An exception, that could be used when class does not have required function defined.

- [FlowPDF::Exception::MissingFunctionArgument](/doc/md/FlowPDF/Exception/MissingFunctionArgument.md)

    An exception, that could be used when function expecting required parameter, and this parameter is missing.

- [FlowPDF::Exception::WrongFunctionArgumentType](/doc/md/FlowPDF/Exception/WrongFunctionArgumentType.md)

    An exception, that could be used when function received an argument, but it has different type.

- [FlowPDF::Exception::WrongFunctionArgumentValue](/doc/md/FlowPDF/Exception/WrongFunctionArgumentValue.md)

    An exception, that could be used when function received an argument, but its value is wrong.

- [FlowPDF::Exception::EntityDoesNotExist](/doc/md/FlowPDF/Exception/EntityDoesNotExist.md)

    An exception, that could be used when something does not exist, but it should. Like key in hash.

- [FlowPDF::Exception::EntityAlreadyExists](/doc/md/FlowPDF/Exception/EntityAlreadyExists.md)

    An exception, that could be used when something exists, but it should not, like user with the same email.

- [FlowPDF::Exception::RuntimeException](/doc/md/FlowPDF/Exception/RuntimeException.md)

    A generic runtime exception.

## Few words about exceptions handling in FlowPDF

We strongly recommend to use Try::Tiny for exceptions handling because eval {} approach has a lot of flaws.

Pne of them is that exception, that was raised during eval {} is automatically being assigned to global variable $@.
There are too many things that could go wrong. Try::Tiny is available in ec-perl.

For example:

```perl

try {
    ...;
} catch {
    ...;
} finally {
    ...;
}

```

# USING OUT-OF-THE-BOX EXCEPTIONS

To use any of out of the box exceptions you need to import them as regular perl module,
then create an exception object (see documentation for an exception that you want create),
then throw and then catch. For example, we will be using [FlowPDF::Exception::UnexpectedEmptyValue](/doc/md/FlowPDF/Exception/UnexpectedEmptyValue.md) as example.

```perl

use strict;
use warnings;
use Try::Tiny;
\# 1. Import.
use FlowPDF::Exception::UnexpectedEmptyValue;
use FlowPDF::Log;

try {
    dangerous('');
} catch {
    my ($e) = @_;
    # 3. Validate.
    if ($e->is('FlowPDF::Exception::UnexpectedEmptyValue')) {
        # 4. Handle.
        logInfo("Unexpected empty value caught: $e");
    }
};

sub dangerous {
    my ($arg) = @_;

    unless ($arg) {
        # 2. Create and throw.
        FlowPDF::Exception::UnexpectedEmptyValue->new({
            where    => '1st argument',
            expected => 'non-empty value'
        })->throw();
    }
}

```

# CREATING YOUR OWN EXCEPTIONS

To create your own exceptions for a plugin, you need to do the following things:

- Inherit FlowPDF::Exception
- Define exceptionCode method

    This method should return a line, that will be used as code for your exception. It could be:

    ```perl

    sub exceptionCode {
        return 'CUST001';
    }

    ```

- Define render or template methods.

    You need to define only one of them.
    Template method should return sprintf template, which will be used during exception object creation.
    This template will be interpolated using parameters from new() method. This is simple way.

    Render method accepts all parameters, that were provided to new() method, but you have to return ready-to-use message.
    This method is more advanced way of exceptions creation and provides full control.

Simple exception using render could be implemented like that:

```perl

package FlowPDF::Exception::WithRender;
use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'WTHRNDR01';
}

sub render {
    my ($class, @params) = @_;
    my $message = "Following keys are wrong: " . join(', ', @params);
    return $message;
}

1;

```