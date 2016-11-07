component  output="false" {
	
	
	remote any function doSomething (
		required	numeric			argNumeric,
		required	string			argString,
		required	boolean			argBoolean,
		required	date			argDate,
		required	array			argArray		jdsArrayType="date",
		required	struct			argStruct,
		required	models.TestObj	argTestObj,
		required	array			argTestSubObjArr jdsArrayType="models.TestSubObj"
	) jdsAutoDeserialize {
		
		return arguments;
	}
	
	
}