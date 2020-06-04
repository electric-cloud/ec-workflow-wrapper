# Procedure parameters:
{% for parameter in procedure.parameters -%}
# {{parameter.name}}
{% endfor %}
sub collectReportingData {
    my $self = shift;
    my $params = shift;
    my $stepResult = shift;

    die 'Not implemented yet';

    {% if payloads.size() > 1 %}
    # Multiple Payloads
    {% for payloadName, payload in payloads %}
    if ($params->{reportObjectType} eq '{{payloadName}}') {
        my ${{payloadName}}Reporting = FlowPDF::ComponentManager->loadComponent('FlowPlugin::{{pluginClassName}}::Reporting', {
            reportObjectTypes     => [ '{{payloadName}}' ],
            metadataUniqueKey     => 'fill me in',
            payloadKeys           => [ 'fill me in' ]
        }, $self);
        ${{payloadName}}Reporting->CollectReportingData();
    }
    {% endfor %}
    {% else %}
    {%- for payloadName, payload in payloads %}
    my ${{payloadName}}Reporting = FlowPDF::ComponentManager->loadComponent('FlowPlugin::{{pluginClassName}}::Reporting', {
        reportObjectTypes     => [ '{{payloadName}}' ],
        metadataUniqueKey     => 'fill me in',
        payloadKeys           => [ 'fill me in' ]
    }, $self);
    ${{payloadName}}Reporting->CollectReportingData();
    {% endfor -%}
    {% endif %}
}
