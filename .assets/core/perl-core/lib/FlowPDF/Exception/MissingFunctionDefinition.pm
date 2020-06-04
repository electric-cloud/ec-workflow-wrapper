package FlowPDF::Exception::MissingFunctionDefinition;
use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0005MFD';
}

sub render {
    my ($self, $params) = @_;

    my $message = 'Missing function definition.';
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }
    if (ref $params ne 'HASH') {
        return $message;
    }

    if (defined $params->{class} && defined $params->{function}) {
        $message = sprintf("Missing function definition. Class '%s' does not define function '%s'.", $params->{class}, $params->{function});
    }
    elsif (defined $params->{function}) {
        $message = sprintf("Missing function definition. Function %s is not defined.", $params->{function});
    }

    return $message;
}

=head1 NAME

FlowPDF::Exception::MissingFunctionDefinition

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when some class does not have some function defined, but should (wrong implementation).

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

=item class

A class where function is missing.

=item function

A name of the function, that is not implemented (missing).

=back

=back

%%%LANG%%%

FlowPDF::Exception::MissingFunctionDefinition->new({
    class    => 'MyClass',
    function => 'mySub'
})->throw();

%%%LANG%%%

=cut

1;
