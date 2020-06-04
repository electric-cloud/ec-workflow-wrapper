import java.io.File

def procName = 'Setup'
procedure procName, description: 'Retrieves Groovy dependencies. This procedure can be used as a first step of the procedure which requires dependencies.', {
    property 'standardStepPicker', value: false

	step 'Setup',
        command: new File(pluginDir, "dsl/procedures/RetrieveDependencies/steps/retrieveDependencies.pl").text,
        shell: 'ec-perl'
}

