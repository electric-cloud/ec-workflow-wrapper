# NAME

FlowPDF::ContextFactory

# AUTHOR

CloudBees

# DESCRIPTION

A context factory that generates the [FlowPDF::Context](/doc/md/FlowPDF/Context.md) object.

# METHODS

- **newContext**

    Creates new context object. Accepts as parameters a hashref with the following fields:

    - **procedureName**

        Name of procedure where we are.

    - **stepName**

        Name of current step that is being executed.

    - **pluginObject**

        An [FlowPDF](/doc/md/FlowPDF.md) object or an object that inherits FlowPDF.

    - **ec**

        An ElectricCommander object.

        This method should not be used directly without reason. ContextFactory has been designed to be used inside of [FlowPDF](/doc/md/FlowPDF.md) in a seamless way.