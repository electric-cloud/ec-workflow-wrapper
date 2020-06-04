$[/myProject/perl/core/scripts/preamble.pl]

use FlowPlugin::{{pluginClassName}};
# Auto generated code of plugin step
# Go to dsl/properties/perl/lib/EC/Plugin/{{pluginClassName}}.pm and change the function "{{ stepMethodName }}"
FlowPlugin::{{pluginClassName}}->runStep('{{step.procedure.name}}', '{{ step.name }}', '{{stepMethodName}}');
