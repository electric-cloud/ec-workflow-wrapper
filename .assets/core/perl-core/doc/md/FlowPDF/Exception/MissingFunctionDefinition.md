# NAME

FlowPDF::Exception::MissingFunctionDefinition

# AUTHOR

CloudBees

# DESCRIPTION

An exception that represents a situation when some class does not have some function defined, but should (wrong implementation).

# USAGE

This exception could be created using new() method in one of the following ways:

- No parameters

    Exception with default message will be created.

- Custom scalar parameter

    Exception with custom message will be created.

- hashref with the following fields as parameter:

    **Note:** you may not use all of these arguments at once. It is allowed to omit some of them.

    - class

        A class where function is missing.

    - function

        A name of the function, that is not implemented (missing).

```

FlowPDF::Exception::MissingFunctionDefinition->new({
    class    => 'MyClass',
    function => 'mySub'
})->throw();

```