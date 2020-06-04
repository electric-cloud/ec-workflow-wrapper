# NAME

# FlowPDF::Component::CLI

# AUTHOR

CloudBees

# DESCRIPTION

FlowPDF::Component::CLI is an FlowPDF::Component that is responsible for command-line execution.

# INIT PARAMS

To read more about init params see [FlowPDF::ComponentManager](/doc/md/FlowPDF/ComponentManager.md).

This component support following init params:

- (Required) workingDirectory

    A parameter for working directory. CLI executor will chdir to this directory before commands execution.

- (Optional) resultsDirectory

    A parameter for output directory. Logs are being stored at this directory.

    If no resultsDirectory parameter, defaults to workingDirectory parameter.

# USAGE

This component should be used in the following sequence:

- FlowPDF::Component::CLI creation.
- FlowPDF::Component::CLI command creation.
- Command execution.
- Results procession.

# METHODS

## newCommand($shell, $args)

### Description

Creates an [FlowPDF::Componen::CLI::Command](/doc/md/FlowPDF/Componen/CLI/Command.md) object that represents command line and being used by FlowPDF::Component::CLI executor.

### Parameters

- (Required)(String) Shell for the command, or full path to the command that should be executed.
- (Required)(ARRAY ref) An arguments that will be escaped and added to the command.

### Returns

- [FlowPDF::Component::CLI::Command](/doc/md/FlowPDF/Component/CLI/Command.md) object

## runCommand()

### Description

Executes provided command and returns an [FlowPDF::Component::CLI::ExecutionResult](/doc/md/FlowPDF/Component/CLI/ExecutionResult.md) object.

### Parameters

- None

### Returns

- [FlowPDF::Component::CLI::ExecutionResult](/doc/md/FlowPDF/Component/CLI/ExecutionResult.md)