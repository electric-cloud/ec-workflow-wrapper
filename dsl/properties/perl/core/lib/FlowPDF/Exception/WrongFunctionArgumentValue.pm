package FlowPDF::Exception::WrongFunctionArgumentValue;
use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0004WAV';
}


sub render {
    my ($self, $params) = @_;

    my $message = 'Got a wrong value for an argument.';
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }

    if (ref $params ne 'HASH') {
        return $message;
    }

    if (defined $params->{argument}) {
        $message = "Got a wrong value of an argument '$params->{argument}'";
    }
    else {
        $message = 'Got a wrong value for an argument';
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

FlowPDF::Exception::WrongFunctionArgumentValue

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when function received an argument that has a wrong value.

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

An argument, that has a wrong value.

=item function

A name of the function, that received an argument with a wrong value.

=item got

A value of argument that were gotten.

=item expected

An expected value of an argument.

=back

=back

%%%LANG%%%

FlowPDF::Exception::WrongFunctionArgumentValue()->new({
    argument => 'user name',
    function => 'greetUser',
    got      => 'HASH',
    expected => 'scalar'
})->throw();

%%%LANG%%%

=cut

1;
