component {
	
	
	public struct function deserializeMethodArguments(required struct jsonArguments, required array methodArgumentsDefinition) {
		local.deserializedArguments = {};
		
		for (local.argumentDefinition in arguments.methodArgumentsDefinition) {
			for (local.jsonArgument in arguments.jsonArguments) {
				if (argumentDefinition.name == jsonArgument) {
					local.dataType = argumentDefinition.type;
					if (dataType == "array" && isDefined("argumentDefinition.jdsArrayType")) {
						dataType = argumentDefinition.jdsArrayType & "[]";
					}
					deserializedArguments[argumentDefinition.name] = deserializeObject(
						obj			= deserializeJSON(arguments.jsonArguments[jsonArgument]),
						dataType	= dataType
					);
					break;
				}
			}
		}
		
		return deserializedArguments;
	}
	
	
	public any function deserializeObject(required any obj, required string dataType) {
		switch (arguments.dataType) {
			case "any":
			case "string":
			case "numeric":
			case "boolean":
			case "struct":
			case "array":
				return obj;
			case "date":
				if (isSimpleValue(obj)) {
					local.dateString = obj.replaceFirst("^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$", "$1-$2-$3 $4");
					if (isDate(dateString)) {
						return parseDateTime(dateString);
					}
				}
				return obj;
			default:
				if (arguments.dataType.endsWith("[]")) {
					local.objArr = [];
					local.objItemComponentType = left(arguments.dataType, len(arguments.dataType) - 2);
					for (local.objJsonItem in arguments.obj) {
						local.objItemInstance = deserializeObject(
							obj			= objJsonItem,
							dataType	= objItemComponentType
						);
						arrayAppend(objArr, objItemInstance);
					}
					return objArr;
				}
				local.objInstance = createObject("component", arguments.dataType);
				local.objMetadata = getMetadata(objInstance);
				
				for (local.objProperty in objMetadata.properties) {
					local.isObjParameterFound = false;
					if (objProperty.serializable) {
						for (local.objStructKey in arguments.obj) {
							if (objProperty.name == objStructKey) {
								isObjParameterFound = true;
								local.value = deserializeObject(arguments.obj[objStructKey], objProperty.type);
								invoke(objInstance, "set" & objProperty.name, [value]);
								break;
							}
						}
						if (!isObjParameterFound && objProperty.required) {
							throw("Serialization error. #objProperty.name# property is required but is missing");
						}
					}
				}
				return objInstance;
		}
	}
	
	
}