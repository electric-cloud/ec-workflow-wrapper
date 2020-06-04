# NAME

FlowPDF::Component::OAuth;

# AUTHOR

CloudBees

# DESCRIPTION

A component to integrate with OAuth 1.0

# INIT PARAMS

To read more about init params see [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md).

This component support following init params:

- (Required) base\_url
- (Required) oauth\_consumer\_key
- (Required) oauth\_signature\_method
- (Required) oauth\_version
- (Optional) oauth\_nonce
- (Optional) oauth\_timestamp
- (Optional) oauth\_version
- (Optional) request\_method
- (Optional) oauth\_token
- (Optional) oauth\_verifier
- (Optional) oauth\_callback
- (Optional) oauth\_signature

# USAGE

```perl

    my $rest = FlowPDF::Client::REST->new({
        oauth => {
            private_key=> $privateKey,
            oauth_token => $token,
            oauth_consumer_key => $oauthConsumerKey,
            oauth_version => '1.0'
        }
    });
    my $jiraUrl = 'http://jira:8080';
    # rest client will automatically load FlowPDF::Component::OAuth. You just need to get it.
    my $oauth = FlowPDF::ComponentManager->getComponent('FlowPDF::Component::OAuth');
    # create a hash reference request params, using oauth component
    my $requestParams = $oauth->augment_params_with_oauth('GET', $jiraUrl, {});
    # add these parameters to the request URL.
    $jiraUrl = $rest->augmentUrlWithParams($jiraUrl, $requestParams);
    # create request
    my $request = $rest->newRequest(GET => $jiraUrl);
    my $response = $rest->doRequest($request);

```

- **new**
- **request**
- **augment\_params\_with\_oauth**
- **calculate\_the\_signature**

    Collect all parameters for signature string:
      - Request method
      - Request path
      - All parameters that will be in query (collect and encode all at once)

- **parse\_token\_response**
- **request\_token**
- **authorize\_token**
- **generate\_auth\_url**
- **renew\_nonce**
- **\_encode**
- **\_parse\_url\_encoded**
- **ua**