use strict;
use ElectricCommander;

my $ec = ElectricCommander->new;

eval {
    # Write your code for checking connectivity here, e.g.
    my $connectionSucceeded = 1;
    unless($connectionSucceeded) {
        die "Connection failed: code $connectionSucceeded";
    }
};

# If the block code in eval {} dies
if ($@) {
    my $msg = $@;
    $ec->setProperty('/myJob/configError', $msg);
    $ec->setProperty('/myJobStep/summary', $msg);
    exit 1;
};
