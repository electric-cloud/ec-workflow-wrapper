sub validateCRDParams {
    my $self = shift;
    my $params = shift;
    my $stepResult = shift;

    # Add parameters check here, e.g.
    # if (!$params->{myField}) {
    #     use FlowPDF::Helpers qw/bailOut/;
    #     bailOut("Field myField is required");
    # }

    $stepResult->setJobSummary('success');
    $stepResult->setJobStepOutcome('Parameters check passed');

    exit 0;
}
