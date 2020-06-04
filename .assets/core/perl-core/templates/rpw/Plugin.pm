## === step template ===
# Auto-generated method for the procedure {{ step.procedure.name }}/{{step.name}}
# Add your code into this method and it will be called when step runs
{% for parameter in  step.procedure.parameters -%}
# Parameter: {{ parameter.name }}
{% endfor %}
sub {{stepMethodName}} {
    my ($pluginObject) = @_;

    my $context = $pluginObject->getContext();
    my $params = $context->getRuntimeParameters();

    {%- set getClientMethod = "get" ~ restModuleName %}
    {%- set clientVar = '$' ~ restModuleName %}

    my {{clientVar}} = $pluginObject->{{getClientMethod}};
    # If you have changed your parameters in the procedure declaration, add/remove them here
    my %restParams = (
        {%- for param in step.procedure.parameters -%}
        {%- if param.restParameter %}
        '{{ param.restParameter.parameterName}}' => $params->{'{{param.name}}'},
        {%- endif -%}
        {%- endfor %}
    );
    my $response = {{clientVar}}->{{step.procedure.restEndpoint.methodName}}(%restParams);
    logInfo("Got response from the server: ", $response);

    my $stepResult = $context->newStepResult;
    {%- for op in step.procedure.outputParameters %}
    {% if op.rest -%}
    $stepResult->setOutputParameter('{{op.name}}', encode_json($response));
    {%- endif -%}
    {%- endfor %}

    $stepResult->apply();
}

## === step template ends ===

## === rest client template ===
# This method is used to access auto-generated REST client.
sub get{{restModuleName}} {
    my ($self) = @_;

    my $context = $self->getContext();
    my $config = $context->getRuntimeParameters();
    require FlowPlugin::{{restModuleName}};
    my $client = FlowPlugin::{{restModuleName}}->createFromConfig($config);
    return $client;
}
## === rest client template ends ===

