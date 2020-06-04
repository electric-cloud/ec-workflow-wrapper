use strict;
use warnings;
use ElectricCommander;

my $ec = ElectricCommander->new;
my $authType = $ec->getPropertyValue('authType');


if (!$authType || $authType eq 'basic') {

}
