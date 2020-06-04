NAME
====

FlowPDF::Component::OAuth;

AUTHOR
======

CloudBees

DESCRIPTION
===========

A component to integrate with OAuth 1.0

INIT PARAMS
===========

To read more about init params see
`FlowPDF::ComponentManager <flowpdf-perl-lib/FlowPDF/ComponentManager.html>`__.

This component support following init params:

-  (Required) base_url
-  (Required) oauth_consumer_key
-  (Required) oauth_signature_method
-  (Required) oauth_version
-  (Optional) oauth_nonce
-  (Optional) oauth_timestamp
-  (Optional) oauth_version
-  (Optional) request_method
-  (Optional) oauth_token
-  (Optional) oauth_verifier
-  (Optional) oauth_callback
-  (Optional) oauth_signature

USAGE
=====

.. code:: perl


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

-  **new**

-  **request**

-  **augment_params_with_oauth**

-  **calculate_the_signature**

   Collect all parameters for signature string: - Request method -
   Request path - All parameters that will be in query (collect and
   encode all at once)

-  **parse_token_response**

-  **request_token**

-  **authorize_token**

-  **generate_auth_url**

-  **renew_nonce**

-  **\_encode**

-  **\_parse_url_encoded**

-  **ua**
