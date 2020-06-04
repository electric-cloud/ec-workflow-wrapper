package FlowPlugin::{{pluginClassName}};
use strict;
use warnings;
use base qw/FlowPDF/;
use FlowPDF::Log;

# Feel free to use new libraries here, e.g. use File::Temp;

# Service function that is being used to set some metadata for a plugin.
sub pluginInfo {
    return {
        pluginName          => '@PLUGIN_KEY@',
        pluginVersion       => '@PLUGIN_VERSION@',
        configFields        => ['config'],
        configLocations     => ['ec_plugin_cfgs'],
        defaultConfigValues => {}
    };
}

## === step template ===
# Auto-generated method for the procedure {{ step.procedure.name }}/{{step.name}}
# Add your code into this method and it will be called when step runs
# $self - reference to the plugin object
# $p - step parameters
# $sr - StepResult object
sub {{stepMethodName}} {
    my ($self, $p, $sr) = @_;

    my $context = $self->getContext();
    logInfo("Current context is: ", $context->getRunContext());
    logInfo("Step parameters are: ", $p);

    my $configValues = $context->getConfigValues();
    logInfo("Config values are: ", $configValues);

    $sr->setJobStepOutcome('warning');
    $sr->setJobSummary("This is a job summary.");
}
## === step template ends ===
## === step ends ===
# Please do not remove the marker above, it is used to place new procedures into this file.

## === feature step template ===
{{featureStepCode}}
## === feature step template ends ===

1;
