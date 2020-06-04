package FlowPDF::Exception::WrongFunctionArgumentType;
use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0003WAT';
}

# TODO: make render function working with different format.
sub render {
    my ($self, $params) = @_;

    my $message = 'Got an argument of a wrong type.';
    # return exception as is
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }

    if (ref $params ne 'HASH') {
        return $message;
    }

    if (defined $params->{argument}) {
        $message = "Wrong type for argument '$params->{argument}'";
    }
    else {
        $message = 'Got an argument of a wrong type';
    }

    if (defined $params->{function}) {
        $message .= " of a function '$params->{function}'";
    }

    if (defined $params->{got}) {
        $message .= ", got: '$params->{got}'";
    }

    if (defined $params->{expected}) {
        $message .= ", expected: '$params->{expected}'";
    }

    $message .= '.';
    return $message;
}


=head1 NAME

FlowPDF::Exception::WrongFunctionArgumentType

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when function received an argument of a type, that is not suitable.

=head1 USAGE

This exception could be created using new() method in one of the following ways:

=over

=item No parameters

Exception with default message will be created.

=item Custom scalar parameter

Exception with custom message will be created.

=item hashref with the following fields as parameter:

B<Note:> you may not use all of these arguments at once. It is allowed to omit some of them.

=over 4

=item argument

An argument, that has a wrong type.

=item function

A name of the function, that received an argument of a wrong type.

=item got

A type of argument that were gotten.

=item expected

An expected type of an argument.

=back

=back

%%%LANG%%%

FlowPDF::Exception::MissingFunctionArgument->new({
    argument => 'user name',
    function => 'greetUser',
    got      => 'HASH',
    expected => 'scalar'
})->throw();

%%%LANG%%%

=cut

1;
