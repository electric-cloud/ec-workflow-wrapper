package FlowPDF::Exception::EntityAlreadyExists;

use base qw/FlowPDF::Exception/;
use strict;
use warnings;

sub exceptionCode {
    return 'CBF0007EAE';
}

sub render {
    my ($self, $params) = @_;

    my $message = 'Entity already exists.';
    if (!ref $params) {
        $params ||= $message;
        return $params;
    }

    my $tempMessage = '';
    if ($params->{entity}) {
        $tempMessage = "Entity '$params->{entity}' already exists";
    }
    else {
        $tempMessage = $message;
        $tempMessage =~ s/\.+$//;
    }
    if ($params->{in}) {
        $tempMessage .= " in '$params->{in}'";
    }
    if ($params->{function}) {
        $tempMessage .= " in function $params->{function}";
    }

    $tempMessage .= '.';

    $message = $tempMessage;

    return $message;
}

=head1 NAME

FlowPDF::Exception::EntityAlreadyExists

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

An exception that represents a situation when something already exists, but it should not. Like user with the same email in the database.

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

An entity, that already exists.

=item in

A place, where entity already exists.

=item function

A name of the function in context of which entity already exists.

=back

=back

%%%LANG%%%

FlowPDF::Exception::EntityAlreadyExists->new({
    entity => 'key email',
    in => 'users array',
    function => 'newUser'
})->throw();

%%%LANG%%%

=cut

1;
