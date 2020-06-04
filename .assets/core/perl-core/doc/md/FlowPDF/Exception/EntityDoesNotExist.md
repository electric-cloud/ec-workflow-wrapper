# NAME

FlowPDF::Exception::EntityDoesNotExist

# AUTHOR

CloudBees

# DESCRIPTION

An exception that represents a situation when something does not exist, but it should. Like required parameter in a hashref.

# USAGE

This exception could be created using new() method in one of the following ways:

- No parameters

    Exception with default message will be created.

- Custom scalar parameter

    Exception with custom message will be created.

- hashref with the following fields as parameter:

    **Note:** you may not use all of these arguments at once. It is allowed to omit some of them.

    - entity

        An entity, that does not exist.

    - in

        A place, where entity does not exist.

    - function

        A name of the function in context of which entity does not exist.

```

FlowPDF::Exception::EntityDoesNotExist->new({
    entity => 'key email',
    in => 'users array',
    function => 'newUser'
})->throw();

```