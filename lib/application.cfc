component {
	
	
	public any function onCFCRequest(
		required string cfcName,		// component requested by the user
		required string method,			// method requested by the user
		required any	args			// argument collection sent by the user. Can be either struct or array
	) {
		local.componentInstance	= createObject("component", arguments.cfcName);
		local.metadata			= getMetadata(componentInstance[arguments.method]);
		
		if (!structKeyExists(metadata, "access") || metadata.access != "remote") {
			throw(message="Invalid method called", type="InvalidMethodException", detail="The method #arguments.method# does not exists or is inaccessible remotely");
		}
		
		if (isDefined("metadata.jdsAutoDeserialize")) {// deserialize WEB service arguments if Auto Deserialization enabled
			local.deserializedArguments = new JSONDeserializer().deserializeMethodArguments(arguments.args, metadata.parameters);
			return invoke(componentInstance, arguments.method, deserializeMethodArguments(arguments.args, deserializedArguments));
		}
		
		return invoke(componentInstance, arguments.method, arguments.args);
	}
	
	
}