import java.io.File

procedure 'flowpdk-setup', description: 'Delivers binary dependencies from the Flow server to the agent', {

    // don't add a step picker for this procedure since it is internally invoked
    property 'standardStepPicker', value: false

    step 'setup',
          command: new File(pluginDir, 'dsl/procedures/flowpdkSetup/steps/setup.pl').text,
          errorHandling: 'failProcedure',
          exclusiveMode: 'none',
          postProcessor: 'postp',
          releaseMode: 'none',
          shell: 'ec-perl',
          timeLimitUnits: 'minutes'

    property 'ec_compressAndDeliver', value: new File(pluginDir, 'dsl/procedures/flowpdkSetup/compressAndDeliver.groovy').text


    formalParameter 'generateClasspathFromFolders', {
        required = '0'
        defaultValue = ''
        type = 'entry'
    }

    formalParameter 'dependsOnPlugins', {
      required = '0'
      defaultValue = ''
      type = 'entry'
    }
}

