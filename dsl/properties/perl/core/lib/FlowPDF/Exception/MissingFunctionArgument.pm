package FlowPDF::Exception::MissingFunctionArgument;
use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0002MFA';
}

sub render {
    my ($self, $params) = @_;

    my $message = 'Missing function argument.';
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }


    if (ref $params eq 'HASH') {
        # if (defined $argumentName && defined $functionName) {
        if ($params->{argument} && $params->{function} ) {
            $message = sprintf("Missing '%s' argument for a function '%s'.", $params->{argument}, $params->{function});
        }
        elsif ($params->{argument}) {
            $message = sprintf("Missing '%s' argument.", $params->{argument});
        }
        else {
            $message = 'Missing function argument.';
        }
    }
    return $message;
}

=head1 NAME

FlowPDF::Exception::MissingFunctionArgument

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when function didn't receive a mandatory parameter.

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

An argument, that is missing.

=item function

A name of the function, that didn't receive a mandatory argument.

=back

=back

%%%LANG%%%

FlowPDF::Exception::MissingFunctionArgument->new({
    argument => 'user name',
    function => 'greetUser'
})->throw();

%%%LANG%%%

=cut

1;
