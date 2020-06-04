// === promote_autogen starts ===
// === promote_autogen template ===
{%- import _self as this -%}
{%- macro recursiveProperty (property) %}
property '{{ property.name }}', {% if property.credentialProtected %}credentialProtected: "1", {% endif %}{
{% if property.description %}description = '{{property.description}}'{% endif %}
{% if property.expandable %}{% else %}expandable = false{% endif %}
{% if property.value %}
{% if property.value.path %}
value = new File(pluginDir, "{{property.value.path}}").text
{% else %}
value = '{{ property.value.value }}'
{% endif %}
{% else %}
{% if property.ecProperties.size() %}
{% for p in property.ecProperties %}
{% import _self as recursive %}
{{ recursive.recursiveProperty(p)}}
{% endfor %}
{% endif %}
{% endif %}
}
{% endmacro -%}
import groovy.transform.BaseScript
import com.electriccloud.commander.dsl.util.BasePlugin

//noinspection GroovyUnusedAssignment
@BaseScript BasePlugin baseScript

// Variables available for use in DSL code
def pluginName = args.pluginName
def upgradeAction = args.upgradeAction
def otherPluginName = args.otherPluginName

def pluginKey = getProject("/plugins/$pluginName/project").pluginKey
def pluginDir = getProperty("/projects/$pluginName/pluginDir").value

//List of procedure steps to which the plugin configuration credentials need to be attached
def stepsWithAttachedCredentials = [
    {% for step in stepsWithCredentials -%}
    [procedureName: "{{ step.procedureName }}", stepName: "{{ step.stepName }}"],
    {% endfor %}
]

project pluginName, {
    property 'ec_keepFilesExtensions', value: 'true'
    property 'ec_formXmlCompliant', value: 'true'
    loadPluginProperties(pluginDir, pluginName)
    loadProcedures(pluginDir, pluginKey, pluginName, stepsWithAttachedCredentials)

    {% if config %}
    // Plugin configuration metadata
    property 'ec_config', {
        configLocation = 'ec_plugin_cfgs'
        form = '$[' + "/projects/$pluginName/procedures/CreateConfiguration/ec_parameterForm]"
        property 'fields', {
            property 'desc', {
                property 'label', value: 'Description'
                property 'order', value: '1'
            }
        }
    }
    {% endif %}

    {% if features.size() > 0 -%}
    {% for feature in features %}
    // Feature: {{feature.name}}
    {{feature.code}}
    {% endfor -%}
    {%- endif %}

    {%- if pluginspec.ecProperties %}
    // Properties
    {%- for p in pluginspec.ecProperties %}
    {{this.recursiveProperty(p)}}
    {% endfor -%}
    {% endif -%}
}

def retainedProperties = []
{% for property in updateOptions.retainedProperties %}
retainedProperties << '{{property}}'
{%- endfor %}
upgrade(upgradeAction, pluginName, otherPluginName, stepsWithAttachedCredentials, 'ec_plugin_cfgs', retainedProperties)
// === promote_autogen template ends ===
// === promote_autogen ends ===
// Do not edit the code above this line

project pluginName, {
    // You may add your own DSL instructions below this line, like
    // property 'myprop', {
    //     value: 'value'
    // }
}
