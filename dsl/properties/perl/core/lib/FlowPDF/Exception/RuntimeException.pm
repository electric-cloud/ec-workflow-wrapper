package FlowPDF::Exception::RuntimeException;
use strict;
use warnings;
use base qw/FlowPDF::Exception/;

sub exceptionCode {
    return 'CBF0008RTE';
}

sub render {
    my ($self, @messages) = @_;

    return 'Runtime exception.' unless @messages;
    return join '', @messages;
}

=head1 NAME

FlowPDF::Exception::RuntimeException

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a generic runtime exception.

=head1 USAGE

This exception could be created using new() method in one of the following ways:

=over

=item No parameters

Exception with default message will be created.

=item Custom scalar parameter

Exception with custom message will be created.


=back

%%%LANG%%%

FlowPDF::Exception::RuntimeException->new("Error evaluating code.")->throw();

%%%LANG%%%

=cut

1;
