package FlowPlugin::{{pluginClassName}}::Reporting;
use Data::Dumper;
use base qw/FlowPDF::Component::EF::Reporting/;
use FlowPDF::Log;
use strict;
use warnings;

# todo more sample boilerplate
sub compareMetadata {
    my ($self, $metadata1, $metadata2) = @_;

    die 'Not implemented';

    my $value1 = $metadata1->getValue();
    my $value2 = $metadata2->getValue();
    # Implement here logic of metadata values comparison.
    # Return 1 if there are newer records than record to which metadata is pointing.
    return 1;
}

sub initialGetRecords {
    my ($self, $pluginObject, $limit) = @_;

    die 'Not implemented';
    # build records and return them
    # todo required fields
    my $records = $pluginObject->yourMethodTobuildTheRecords($limit);
    return $records;
}

sub getRecordsAfter {
    my ($self, $pluginObject, $metadata) = @_;

    die 'Not implemented';
    # build records using metadata as start point using your functions
    my $records = $pluginObject->yourMethodTobuildTheRecordsAfter($metadata);
    return $records;
}

sub getLastRecord {
    my ($self, $pluginObject) = @_;

    die 'Not implemented';
    my $lastRecord = $pluginObject->yourMethodToGetLastRecord();
    return $lastRecord;
}

sub buildDataset {
    my ($self, $pluginObject, $records) = @_;

    die 'Not implemented';

    my $dataset = $self->newDataset(['yourReportObjectType']);
    for my $row (@$records) {
        # now, data is a pointer, you need to populate it by yourself using it's methods.
        my $data = $dataset->newData({
            reportObjectType => 'yourReportObjectType',
        });
        for my $k (keys %$row) {
            $data->{values}->{$k} = $row->{$k};
        }
    }
    return $dataset;
}



1;
