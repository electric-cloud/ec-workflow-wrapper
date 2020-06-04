
#!/usr/bin/env perl
# line 3 "preamble.pl"

use strict;
use warnings;
use ElectricCommander::PropDB;

BEGIN {
    use Carp;
    use ElectricCommander;
    local $| = 1;

    # Make 'use Foo;' search in properties as well
    # If property exists, wrap it into a "file" and present to Perl CORE
    # Also makes errors/warnings show correct filename and line
    # The local versions of modules are preferred, load from prop as a last
    #     resort.
    my $ec = ElectricCommander->new;
    # my $prefix = '/myProject/lib/';
    # core/lib is a location for the framework.
    # lib is a regular properties.
    my @locations = ('/myProject/perl/core/lib/', '/myProject/perl/lib/');
    my $display;
    my $load = sub {
        my ($self, $target) = @_;

        $display = '[EC]@PLUGIN_KEY@-@PLUGIN_VERSION@/' . $target;
        # Undo perl'd require transformation
        # Retrieving framework part and lib part.
        my $code;
        for my $prefix (@locations) {
            my $prop = $target;
            # $prop =~ s#\.pm$##;

            $prop = "$prefix$prop";
            $code = eval {
                $ec->getProperty("$prop")->findvalue('//value')->string_value;
            };
            last if $code;
        }
        return unless $code; # let other module paths try ;)

        # Prepend comment for correct error attribution
        $code = qq{# line 1 "$display"\n$code};

        # We must return a file in perl < 5.10, in 5.10+ just return \$code
        #    would suffice.
        open my $fd, "<", \$code
            or die "Redirect failed when loading $target from $display";

        return $fd;
    };

    push @INC, $load;
};
