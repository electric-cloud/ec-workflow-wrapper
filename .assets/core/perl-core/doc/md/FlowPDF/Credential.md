# NAME

FlowPDF::Credential

# AUTHOR

CloudBees

# DESCRIPTION

This class represents a credential of ElectricFlow.

What is credential in ElectricFlow?

In ElectricFlow credentials are special secured containers for secret values.

# ELECTRIC FLOW CREDENTIALS NAMING CONVENTION

Credentials in electricflow should be named in 2 ways:

- **credential**

    This is default one that is being used as first credential.

- **%name%\_credential**

    In that case credential parameter should be named as %action%\_credential.

    For example, for proxy username and proxy password **proxy\_credential** parameter should be used.

FlowPDF has support of both patterns.

# SYNOPSIS

```perl

    # retrieving parameter of current plugin configuration.
    # in this case credentals is a parameter named credential.
    my $cred = $cofigValues->getParameter('credential');
    # getting type of credential. It is default, private_key, etc,
    my $credentialType = $cred->getCredentialType();
    my $userName = $cred->getUserName();
    my $password = $cred->getSecretValue();
    my $credentialName = $cred->getCredentialName();

```

# METHODS

## getCredentialType()

### Description

Returns different values for different credentials type. For FlowPDF SDK Drop1 only 'default' is supported.

It does not mean, that you can't access credentials of any type with that API.

It means, that currently all credentials are being processed as default ones: username and password, but these fields are optional.

### Parameters:

- None

### Returns

- (String) Credential Type

### Usage

```perl

    my $credType = $cred->getCredentialType();

```

## getUserName()

### Description

Returns a user name that is being stored in the current credential.

### Parameters

- None

### Returns

- (String) Username for current credential object.

### Usage

```perl
    my $userName = $cred->getUserName();
```

## getSecretValue()

### Description

Returns a secret value that is being stored in the current credential.

### Parameters

- None

### Returns

- (String) Secret value from the current credential object

## getCredentialName()

### Description

Returns a name for the current credential.

### Parameters

- None

### Returns

- (String) A name from the current credential.

### Usage

```perl

    my $credName = $cred->getCredentialName();

```