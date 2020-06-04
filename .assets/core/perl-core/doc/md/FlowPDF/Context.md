# NAME

FlowPDF::Context

# AUTHOR

CloudBees

# DESCRIPTION

FlowPDF::Context is a class that represents current running context.

This class allows user to access procedure parameters, config values and define a step result.

# METHODS

## bailOut($params)

### Description

An advanced version of bailOut from [FlowPDF::Helpers](/doc/md/FlowPDF/Helpers.md)::bailOut.
This version has connections with CloudBees Flow and has following benefits:

- Sets a Pipeline Summary.
- Sets a JobStep Summary.
- Sets outcome to Error.
- Adds diagnostic messages to Diagnostic tab of the job.
- Add suggestion if provided.

### Parameters

- (Required)(HASH ref) A hash reference with message and suggestion fields. Message is mandatory, suggestion is optional

### Returns

- None

### Exceptions

- None

### Usage

This function is being used through context object. Also, note, that this function created it's own [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) object.
It means, that if this function is being used, no other [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) objects will be auto-applied.

This function uses bailOut function from [FlowPDF::Helpers](/doc/md/FlowPDF/Helpers.md) package and causes an exception,
 that could not be handled and your step will exit immedieately with code 1.

```perl

\# this function will call an exit 1.
$context->bailOut({
    message    => "File not found",
    suggestion => 'Please, check that you are using correct resource.'
});

```

## getRuntimeParameters()

### Description

A simplified accessor for the step parameters and config values.
This function returns a regular perl HASH ref from  parameters and config values.

Credentials from 'credential' parameter will be present in this hashref as 'user' and password.
Credentials, that have name like 'proxy\_credential' will be mapped to 'proxy\_user' and 'proxy\_password' parameters.

### Parameters

- None

### Returns

- (HASH ref) A merged parameters from step parameters and config values.

### Usage

For example, you have 'query' parameter and 'location' parameter in your procedure form.xml.
In your configuration you have 'credential', 'proxy\_credential', 'contentType' and 'userAgent'.
In that case you can get runtime parameters like:

```perl

    my $simpleParams = $context->getRuntimeParameters();

```

Now, $simpleParams is:

```perl

    {
        # Values from config
        user => 'admin',
        password => '12345',
        proxy_user => 'proxy',
        proxy_password => 'qwerty',
        contentType => 'application/json',
        userAgent => 'Mozilla',
        # values from step parameters
        location => 'California',
        query => 'SELECT * FROM commander.plugins'
    }

```

## getStepParameters()

### Description

Returns a [FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md) object to be used as accessor for current step parameters.
This method does not require parameters.

### Parameters

- None

### Returns

- ([FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md)) Parameters for the current step

### Usage

```perl

    my $params = $context->getStepParameters();
    # this method returns a L<FlowPDF::Parameter> object, or undef, if no parameter with that name has been found.
    my $param = $params->getParameter('myStepParameter');
    if ($param) {
        print "Param value is:", $param->getValue(), "\n";
    }

```

## getConfigValues()

### Description

This method returns a [FlowPDF::Config](/doc/md/FlowPDF/Config.md) object that represents plugin configuration. This method does not require parameters.

### Parameters

- None

### Returns

- ([FlowPDF::Config](/doc/md/FlowPDF/Config.md)) Plugin configuration for current run context

### Usage

```perl

    my $configValues = $context->getConfigValues();
    my $cred = $configValues->getParameter('credential');
    if ($cred) {
        print "Secret value is: ", $cred->getSecretValue(), "\n";
    }

```

## newStepResult()

### Description

This method returns an [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) object, which is being used to work with procedure or pipeline stage output.

### Parameters

- None

### Returns

- ([FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md)) Object for manipulation with pipeline/procedure results.

### Usage

```perl

    my $stepResult = $context->newStepResult();
    ...;
    $stepResult->apply();

```

## newRESTClient($creationParams)

### Description

Creates an [FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md) object, applying components and other useful mechanisms to it during creation.

For now, this method supports following components and tools:

- [FlowPDF::Component::Proxy](/doc/md/FlowPDF/Component/Proxy.md)

    Proxy can be automatically be enabled. To do that you need to make sure that following parameters are present in your configuration:

    - credential with the proxy\_credential name.
    - regular parameter with httpProxyUrl name

    If your configuration has all fields above, proxy component will be applied silently,
    and you can be sure, that all requests that you're doing through [FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md) methods already have proxy enabled.

    Also, note that if you have debugLevel parameter in your configuration, and it will be set to debug,
    debug mode for FlowPDF::ComponentProxy will be enabled by default.

- Basic Authorization

    Basic authorization can be automatically applied to all your rest requests. To do that you need to make sure that following parameters are present in your plugin configuration:

    - authScheme parameter has value "basic"
    - credential with the basic\_credential name

### Parameters

- (Optional) (HASHREF) FlowPDF::Client::REST Object creation params.

### Returns

- [FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md)

### Usage

```perl

    my $rest = $context->newRestClient();
    my $req = $rest->newRequest(GET => 'https://electric-cloud.com');
    my $response = $rest->doRequest($req);
    print $response->decoded_content();

```