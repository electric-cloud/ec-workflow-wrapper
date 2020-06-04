package FlowPDF::Exception::EntityDoesNotExist;

use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0006EDE';
}

sub render {
    my ($self, $params) = @_;

    my $message = 'Entity does not exist.';
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }

    my $tempMessage = '';
    if ($params->{entity}) {
        $tempMessage = "Entity '$params->{entity}' does not exist";
    }
    else {
        $tempMessage = $message;
        $tempMessage =~ s/\.+$//;
    }
    if ($params->{in}) {
        $tempMessage .= " in '$params->{in}'";
    }
    if ($params->{function}) {
        $tempMessage .= " in function '$params->{function}'";
    }

    $tempMessage .= '.';
    # Entitiy X does not exist at Y in funcion Z

    $message = $tempMessage;

    return $message;
}

=head1 NAME

FlowPDF::Exception::EntityDoesNotExist

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when something does not exist, but it should. Like required parameter in a hashref.

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

=item entity

An entity, that does not exist.

=item in

A place, where entity does not exist.

=item function

A name of the function in context of which entity does not exist.

=back

=back

%%%LANG%%%

FlowPDF::Exception::EntityDoesNotExist->new({
    entity => 'key email',
    in => 'users array',
    function => 'newUser'
})->throw();

%%%LANG%%%

=cut

1;
