property 'ec_devops_insight', {
    {% for payloadType in payloadTypes %}
    property '{{payloadType}}', {
        property 'source', value: '{{sourceName}}'
        {% if reporting.generateValidationProcedure %}
        property 'operations', {
            property 'createDOISDataSource', {
                property 'procedureName', value: 'ValidateCRDParams'
            }
            property 'modifyDOISDataSource', {
                property 'procedureName', value: 'ValidateCRDParams'
            }
        }
        {% endif %}
    }
    {%- endfor %}
}
