import java.io.File

// Please do not edit this file
// === configuration template ===
// This part is auto-generated and will be regenerated upon subsequent updates
procedure 'EditConfiguration', description: 'Checks connection for the changed configuration', {
{% if (shell == "ec-groovy" and checkConnection)  %}
    //First, let's download third-party dependencies
    step 'flowpdk-setup', {
        description = "This step handles binary dependencies delivery"
        subprocedure = 'flowpdk-setup'
        actualParameter = [
            generateClasspathFromFolders: '{{generateClasspathFromFolders}}'
        ]
        {% if resourceName %}resourceName = '{{resourceName}}'{% endif %}
    }
{% endif %}

{% if (checkConnectionGeneric) %}
    step 'checkConnectionGeneric',
        command: new File(pluginDir, "dsl/procedures/CreateConfiguration/steps/checkConnectionGeneric{{ checkConnectionGenericExtension }}").text,
        errorHandling: 'abortProcedure',
        shell: '{{checkConnectionGenericShell}}',
        postProcessor: '$[/myProject/perl/postpLoader]',
        condition: '$[/javascript myJob.checkConnection == "true" || myJob.checkConnection == "1"]'
{% else %}
    step 'checkConnection',
        command: new File(pluginDir, "dsl/procedures/CreateConfiguration/steps/checkConnection{{ extension }}").text,
        errorHandling: 'abortProcedure',
        shell: '{{shell}}',
        postProcessor: '$[/myProject/perl/postpLoader]',
        {% if resourceName %}resourceName: '{{resourceName}}',{% endif %}
        condition: '$[/javascript myJob.checkConnection == "true" || myJob.checkConnection == "1"]'
{% endif %}
}
// === configuration template ends ===
// === configuration ends ===
