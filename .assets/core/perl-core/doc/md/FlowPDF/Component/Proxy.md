# NAME

FlowPDF::Component::Proxy

# DESCRIPTION

This module provides standard mechanism for proxy-handling for ElectricFlow plugins.
This implementation should be used any time when proxy requirement appears.

# Q&A

## Why do we need a module, if one can just set environment variables?

It is a good question. Since our current perl is way too old (5.8.8 now), we have some
outdated modules and bugs, that have been fixed in releases after 5.8.8. For example,
we can't use default LWP functionality for https proxy handling due to bugs in LWP.
But there is a way to deal with that. We have Crypt::SSLeay module installed,
that provides requried functionality by the default way of the \*nix OS. It is respects env variables.

This module does **proper** implementation of all that logic and workarounds and should be used as
said in this help and provides a possibility to developer to change actual implementation of proxy
code without changing the interface. It is mush simpler than fix it in each plugin separately.

# AUTHOR

Dmitriy <dshamatr@electric-cloud.com> Shamatrin

# SYNOPSIS

```perl
    use FlowPDF::Component::Proxy;

    # create proxy dispatcher object
    my $proxy = EC::ProxyDriver->new({
        url => 'http://docker:3128',
        username => 'user1',
        password => 'password1',
        debug => 0,
    });

    # apply proxy

    $proxy->apply();

    # run some proxy related code
    ...;

    # detach proxy, if required.
    $proxy->detach();
```

# METHODS

- **new**

    Constructor method, creates proxy dispatcher object.

    ```perl
        my $proxy = EC::ProxyDriver->new({
            url => 'http://docker:3128',
            username => 'user1',
            password => 'password1',
            debug => 0,
        });
    ```

- **apply**

    Applies proxy changes to whole context in a right way. One should use that function
    and be sure that proxy is set.

    ```perl
        $proxy->apply();
    ```

- **detach**

    Disables proxy for a whole context. It could be useful sometimes to revert all changes that was made by apply function.

    ```perl
        $proxy->detach();
    ```

- **url**

    Returns a proxy url if set. Returns empty string if not.

    ```perl
        my $proxy\_url = $proxy->url();
    ```

- **auth\_method**

    Returns a proxy auth method that is being used. Currently only basic is supported,
    which is set as default.

    ```perl
        my $auth\_method = $proxy->auth\_method();
    ```

- **username**

    Returns a proxy auth username if set. Returns empty string if not.

    ```perl
        my $proxy\_url = $proxy->username();
    ```

- **password**

    Returns a proxy auth password if set. Returns empty string if not.

    ```perl
        my $proxy\_url = $proxy->password();
    ```

- **debug**

    Enables and disables debug mode for module.

    To enable:

    ```perl
        $proxy->debug(1);
    ```

    To disable

    ```perl
        $proxy->debug(0);
    ```

- **augment\_request**

    Augments HTTP::Request object with proxy headers.

    ```perl
        my $req = HTTP::Request->new(...);
        $req = $proxy->augment\_request($req);
    ```

- **detach\_request**

    Detaches changes of request and removes added headers.

    ```perl
        $req = $proxy->detach\_request($req);
    ```

- **augment\_lwp**

    Augments LWP::UserAgent object with proxy information.

    ```perl
        my $ua = LWP::UserAgent->new(...);
        $ua = $proxy->augment\_lwp($ua);
    ```

- **detach\_lwp**

    Removes proxy setup from an LWP object.

    ```perl
        $ua = $proxy->detach\_lwp($ua);
    ```