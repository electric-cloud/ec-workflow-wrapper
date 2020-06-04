# NAME

FlowPDF::Component::CLI::Command

# AUTHOR

CloudBees

# DESCRIPTION

This class represents a system command that is being used by [FlowPDF::Component::CLI](/doc/md/FlowPDF/Component/CLI.md).

# METHODS

## new($shell, @args)

### Description

This method returns an FlowPDF::Component::CLI::Command object.

### Parameters

- (Required)(String) Command to be executed
- (Optional)(list of Strings) Arguments to be added to the command.

### Returns

### Usage

```perl

    my $command = FlowPDF::Component::CLI::Command->new('ls', '-la');

```

### Note

It is much better to use newCommand metod from [FlowPDF::Component::CLI](/doc/md/FlowPDF/Component/CLI.md)

## addArguments(@args)

### Description

Adds a new arguments to the command.

### Parameters

- (Required)(list of String) arguments to be added

### Returns

- FlowPDF::Component::CLI::Command self

### Usage

```perl

    my $command = FlowPDF::Component::CLI->newCommand('ls');
    $command->addArguments('-l', '-a');
```

## renderCommand()

### Description

Returns a rendered command with its arguments.

### Parameters

- None

### Returns

- (String) Rendered command.