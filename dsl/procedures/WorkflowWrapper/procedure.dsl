// This procedure.dsl was generated automatically
// DO NOT EDIT THIS BLOCK === procedure_autogen starts ===
procedure 'WorkflowWrapper', description: '''Run a workflow and monitor its progress.''', {

    step 'Launch', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/WorkflowWrapper/steps/Launch.pl").text
        shell = 'ec-perl'
        shell = 'ec-perl'

            shell = '''ec-perl'''

        postProcessor = '''$[/myProject/perl/postpLoader]'''
    }

    step 'Monitor', {
        description = ''
        command = new File(pluginDir, "dsl/procedures/WorkflowWrapper/steps/Monitor.pl").text
        shell = 'ec-perl'
        shell = 'ec-perl'

            shell = '''ec-perl'''

        postProcessor = '''$[/myProject/perl/postpLoader]'''
    }
// DO NOT EDIT THIS BLOCK === procedure_autogen ends, checksum: 95e31b7f7ce17fd106d3f0aae7a7d314 ===
// Do not update the code above the line
// procedure properties declaration can be placed in here, like
// property 'property name', value: "value"
}