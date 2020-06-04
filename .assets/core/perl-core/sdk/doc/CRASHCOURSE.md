# FlowPDF Crash Course


## FlowPDF?

FlowPDF is a **right** way of doing things that we're, as plugin developerts thinking of.

This SDK implements behind the scene all that is required by 99.9% of plugins.

That is:
step parameter retrieval, config values retrieval, multiple credentials in configuration and procedure parameters,
code organization, pipeline results setup, output parameters setup, etc.
Also, this SDK provides a way of integration with ElectricFlow without deep and sometimes painfull knowledge of EF caveats.

## Plugin API

After generation you will see that your plugin has single main class created, which inherits FlowPDF.
This file will be at dsl/properties/perl/lib/EC/Plugin/\_\_YOURCLASS\_\_.pm.

For each procedure of your plugin, function in this file will be created during generation.
To see, which function is for which procedure, visit dsl/procedures/\_\_YOUR\_PROCEDURE\_\_/steps/\_\_YOUR\_PROCEDURE\_\_.pl you will see something like:

```perl
$[/myProject/perl/core/scripts/preamble.pl]
use EC::Plugin::NewRest;
# Auto generated code of plugin step
EC::Plugin::YOURCLASS->runStep('YOURPROCEDURE', 'YOURPROCEDURESTEP', 'functionName');
```

In your main plugin class is function called functionName is already defined. It will be:

```perl
sub functionName {
    my ($pluginObject, $runtimeParameters, $stepResult) = @_;
    ...;
}
```

**$runtimeParameters** is a hash with merged plugin config and procedure parameters.
For additional details refer to [Getting parameters from configurations and step parameters in one shot](#getting-parameters-from-configurations-and-step-parameters-in-one-shot) section.

**$stepResult** is a handler for setting various outputs of procedure, including output parameters. Refer to [Setting step results](#setting-step-results) section.

That's it. Now, using this plugin object ($pluginObject) you can write your own logic.

## Context

Almost everything that we're doing during plugin development is context-dependent.

When we retrieving pipeline parameters, we're doing it in coontext of current pipeline run.

Pipeline parameters don't have any value outside of this pipeline. Same for configuration. Same for step parameters.
We're interested in them only during current procedure or pipeline run. That's why the key concept of FlowPDF SDK is Context.

Context is being created from plugin object using newContext() method. This context is a way of doing context dependent things (they are 99%).

Like that:

```perl
my $context = $pluginObject->newContext();
```

## Retrieving Step Parameters for the current run

After we have a context object, we can retrieve a step parameters using getStepParameters function.

```perl
my $parameters = $context->getStepParameters();
```

Now, parameters are [FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md) object.

Let's say, that we have a credential parameter called credential, that we need for some reason.
Also, let's say that we have an 'url' parameter, that is mandatoty, and 'method' parameter, that is optional.
Now, to get them we may want to write a piece of code that like that:

```perl
my $cred = $parameters->getParameter('credential');
my $url = $parameters->getParameter('url')->getValue();
my $method = undef;
if (my $p = $parameters->getParameter('method')) {
    $method = $p->getValue();
}
my ($username, $password);
if ($cred) {
    $username = $cred->getUserName();
    $password = $cred->getSecretValue();
}
```

Also, you need to know that credential parameter is slightly different from parameter.
When we retrieving parameter, that is parameter, we have a [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) as a result.
But when we retrieving credentials, [FlowPDF::Credential](/doc/md/FlowPDF/Credential.md) is being returned.

If parameter of credential does not exist, undefined value is returned.

To get a value from [FlowPDF::Parameter](/doc/md/FlowPDF/Parameter.md) object one need to call a getValue() method.

Since we plan to have a different types of credentials, we're using username and secret value combination.

So, currently, to get a username and password from plugin parameters, getUserName and getSecretValue functions have to be used.

## Retrieving config values for the plugin

In ElectricFlow plugin configurations are just a sets of properties. The difference is in context again.

You may want to think of plugin configurations as a global values for a whole plugin.

To get config values from configuration for current step one need to do a simple call of getConfigValues. Like that:

```perl
my $configValues = $context->getConfigValues();
```

Now, configValues is an ["FlowPDF::Config object"](#ecpdf-config-object).

It has the same interface as [FlowPDF::StepParameters](/doc/md/FlowPDF/StepParameters.md).

What is interesting about this call is that you don't need to pass a configuration name. It will figure out this by itself.
How?

Let's take a closer look at your main class.
On the top of it you can see something like:

```perl
sub pluginInfo {
    return {
        pluginName    => '@PLUGIN_KEY@',
        pluginVersion => '@PLUGIN_VERSION@',
        configFields  => ['config'],
        configLocations => ['ec_plugin_cfgs'],
    }
}
```

That's it. You can see that plugin definition has configFields and configLocations properties.

Config fields defines a step parameter name where configuration name is being stored, configLocations is the place, where configurations are stored.

Why it is an array reference? It is because you may have in a different procedures a different name of config parameters.
It is not a best practice, and it is not recommended to do it so, but for backward compatibility reason it is possible that names are different.
This applies for previously created plugins.

## Getting parameters from configurations and step parameters in one shot

To retrieve parameters from configuration and step in single structure you could use getRuntimeParameters method from [FlowPDF::Context](/doc/md/FlowPDF/Context.md) package.

This method does not have any arguments and returns a regular perl hash with merged values from configuration and procedure parameters.

Any parameter except checkbox parameters will be mapped to regular perl hash as is. Credentials will be mapped using credential name as a prefix.

Let's say that we have a parameter that called "requestMethod" and "requestContent" in procedure and "credential", "basic\_credential" and "proxy\_credential" in configuration.

Using getRuntimeParameters:

```perl
my $runtimeParameters = $context->getRuntimeParameters();

# runtimeParameters is a HASH reference with following fields:
# user, password, proxy_user, proxy_password, basic_user, basic_password (taken from config)
# requestMethod and requestContent (taken from procedure parameters).

print $runtimeParameters->{requestMethod};
print $runtimeParameters->{proxy_user};
```

## No new plugins should have a different names for a config parameter.

So, basically, newConfigValues is smart enough to go, check your config parameters to get a config name, and go the config locations and retrieve this config.

That's why this function does not have any parameters for now.

The logic is simple. Once you calling something through context object - it is context dependent. Config retrieval through context returns a config values for current context.

Simple as that.

## Setting step results

After you finished execution of your procedure, or even during it, you may want to set properties, output parameters, summary, otcomes, etc.

There is a good way of doing that. It is [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md).

[FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) is a class, that represents a handlers for step results. It is designed to be a queue.

Typical workflow for [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md) is:

 0. One creates an object using context, or use existing one that is being passed to your step function.
 0. One sets an action items using its functions.
 0. One applies changes, or leave them to be applied by FlowPDF.
 
Manual apply is useful when you need to show im the procedure or step summary something that updates during execution.

For example, completion bar.

Following code shows it:

```perl
for my $i (1..100) {
    $stepResult->setJobStepSummary("Progress: $i\%");
    $stepResult->applyAndFlush();
    sleep 1;
}
```

**Important note**

If you're aborting execution using exit function, auto-apply will not be performed because exit function exits from execution immedieately,
no post procedure hooks will be invoked.

So, let's take an example:

```perl
# Step 1. Creating an object.
my $stepResult = $context->newStepResult();
# Step 2. Adding action items.
$stepResult->setOutputParameter('executionResult', 'Successfully finished!');
$stepResult->setJobStepSummary('Done with success');
# Step 3. Applying changes.
$stepResult->apply();
```

For more details about available function, please, visit [FlowPDF::StepResult](/doc/md/FlowPDF/StepResult.md)

## Performing REST requests

To perform rest request one need to get a [FlowPDF::Client::REST](/doc/md/FlowPDF/Client/REST.md) object.

As usual, this object is being created through context object. Like that:

```perl
# retrieving new rest client object.
my $restClient = $context->newRESTClient();
# creating HTTP::Request object using our wrappers
my $req = $restClient->newRequest(GET => 'https://localhost:8080');
# performing request and getting HTTP::Response obhject.
my $response = $restClient->doRequest($req);
# printing response content:
print $response->decoded_content();
```

Please, note, that REST client may perform additional actions for you behind the scene if you're loading it through context object.
REST client can load a proxy, or perform basic authorization. To get more details about that please, refer to [FlowPDF::Context](/doc/md/FlowPDF/Context.md).

For example, to get basic authorization, you need to have 2 additional fields in your configuration:

 0. basic_credential
 0. authScheme
 
If you have these fields, authScheme is set to 'basic' and creating rest client through context,
you will have a rest client that will automatically apply basic auth to all your requests.

If your plugin has only one auth mechanism and it is basic, there is no need to have authScheme config field with value basic.
You can default this value when it is not present in configuration. See default config values section bellow.

## CLI execution

FlowPDF allows you to execute system commands using its interface. It is being shipped with few components.
One of them is a component for cli. It is called FlowPDF::Component::CLI.

To do that, following steps have to be performed.

1\. Load component.
2\. Create CLI executor.
3\. Create command.
4\. Run command.
5\. Process response.

Following example illustrates it:

```perl
# Step 1 and 2. Loading component and creating CLI executor with working directory of current workspace.
my $cli = FlowPDF::ComponentManager->loadComponent('FlowPDF::Component::CLI', {
    workingDirectory => $ENV{COMMANDER_WORKSPACE}
});
# Step 3. Creating new command with ls as shell and -la as parameter.
my $command = $cli->newCommand('ls', ['-la']);
# adding to more parameters for command
$command->addArguments('-lah');
$command->addArguments('-l');
# Step 4. Executing a command
my $res = $cli->runCommand($command);
# Step 5. Processing a response.
print "STDOUT: " . $res->getStdout();
```

## Logging

FlowPDF provides a set of methods for logging inside of your plugin. These methods are being imported in your current namespace by [FlowPDF::Log](/doc/md/FlowPDF/Log.md)

They are:

* logInfo
* logDebug
* logTrace
* logWarning
* logError

If configuration has **debugLevel** field, it will be automatically applied to the whole plugin log level. Please, note, that logDebug and logTrace will be printed only

if debug level is sufficient. There are 3 debug levels:

|Alias  |Value |Functions that will print           |
|---    |---   |---                                 |
| INFO  | 0    | logInfo, logWarning, logError      |
| DEBUG | 1    | INFO level functions and logDebug  |
| TRACE | 2    | DEBUG level functions and logTrace |

To use logger just import FlowPDF::Log and call appropriate method:

```perl
use FlowPDF::Log;

logInfo("This is info");
logError("This is error");
```

Please, note that these functions can dump references, so you can just pass the reference as parameter and get it dumped as Data::Dumper usually does:

```perl
my $reference = {
    one => 'two',
    three => 'four'
};

logInfo("Reference is: ", $reference);
```

## Magic configuratation values

Currently FlowPDF has these magic config values:

| Config Field Name | Description |
| ---               | ---         |
| debugLevel        | A debug level that is set for the plugin. Value of the debugLevel parameter affects verbosity of plugin output. This field is being created by default. |
| authScheme        | This field determines an auth scheme that should be used for FlowPDF::Client::REST to make this kind of authorization behind the scene. It works automatically only if REST client has been created through context object. |
| httpProxyUrl | An URL of HTTP proxy that should be used for REST requests. Works only if REST client has been created through Context object. |
| proxy_credential | A credential that is being used for proxy authorization. Works only if REST client has been created through Context object.| 

## Plugin default config values

FlowPDF has support of default config values. When you have a thing, that should be present in all plugin configs and it is static, or it has only one option for now,
default config values is a way to go.

Let's say, that you have 3 ways of authorization in your plugin, but want start with one.
You have basic, oauth v1 and token. Currently you have only basic. As been said in section related to REST client, there is a way of defaulting some config values.

**Important note**
You can default somehting that does not exist in the plugin config right now. If that field exists, it's value will be used and FlowPDF will show a warning.

Let's say that we're defaulting authScheme to basic. All you need is to add a key to defaultConfigValues hash in your pluginInfo function:

```
sub pluginInfo {
    return {
        pluginName    => '@PLUGIN_KEY@',
        pluginVersion => '@PLUGIN_VERSION@',
        configFields  => ['config'],
        configLocations => ['ec_plugin_cfgs'],
        defaultConfigValues => {
            authScheme => 'basic'
        }
    };
}
```

After that plugin code will think that authScheme field is present in configuration and has a value 'basic'.

## Plugin custom fields

If you need, you can keep your own custom fields in the plugin, using pluginValues field of your plugin object.

You can define them in the pluginInfo subroutine of you main plugin module:

```perl
sub pluginInfo {
    return {
        pluginName    => '@PLUGIN_KEY@',
        pluginVersion => '@PLUGIN_VERSION@',
        configFields  => ['config'],
        configLocations => ['ec_plugin_cfgs'],
        defaultConfigValues => {
            authScheme => 'basic'
        },
        configValues => {
            one => 'two'
        }
    };
}
```

And get them anywhere, using plugin object:

```perl

my $pluginValues = $pluginObject->getPluginValues();
logInfo("Value of one is: $pluginValues->{one}");

```

## Third Party Dependencies

**Important note**

This method of third party dependenices management applicable only for pure perl dependencies.
If dependent perl module is XS, which means that module has 2 parts, one is a library written in c/c++/etc and other part is a perl module that is loading that native library.
This dependency management can handle only perl part, which is .pm file. Binary part of dependency \(native library\) should be handled by plugin developer manually.
At this moment FlowPDF-Perl-Lib does not provide this functionality.


For example, you need to have an external perl dependency in your plugin. Let's say, that you have a module called YourCompany::YourPackage.

In the file system your module is: YourCompany/YourPackage.pm

FlowPDF has support of 3rd party modules. You need to go to the dsl/properties/perl/lib of your plugin and place your module there.

In case of YourCompany::YourPackage it should be dsl/properties/perl/lib/YourCompany/YourPackage.pm.

After build this module will be automatically loaded by FlowPDF-Perl-Lib and will be available as any regular perl module:

```perl

use YourCompany::YourPackage;

```

