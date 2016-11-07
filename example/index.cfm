<cfscript>

testSubObj = new models.TestSubObj(
	propertyNumeric		= 222,
	propertyString		= "propertyString",
	propertyBoolean		= false,
	propertyDate		= now(),
	propertyArray		= [{ ss1 = 22 }, 22],
	propertyStruct		= { key1 = "1key1Value", key2 = "1key2Value" }
);

propertyTestSubObjArr = [testSubObj, testSubObj, testSubObj];

testOb = new models.TestObj(
	propertyNumeric			= 11,
	propertyString			= "propertyString",
	propertyBoolean			= true,
	propertyDate			= now(),
	propertyArray			= [{ ss1 = 11 }, 11],
	propertyStruct			= { key1 = "key1Value", key2 = "key2Value" },
	propertyTestSubObj		= testSubObj,
	propertyTestSubObjArr	= propertyTestSubObjArr
);


componentInstance	= createObject("component", "testWebService");
metadata			= getMetadata(componentInstance["doSomething"]);

deserializedArguments = new lib.JSONDeserializer().deserializeMethodArguments(
	jsonArguments				= {
		argNumeric			= serializeJSON(111),
		argString			= serializeJSON("str"),
		argBoolean			= serializeJSON("true"),
		argDate				= serializeJSON(now()),
		argArray			= serializeJSON([now(), dateAdd("h", 1, now())]),
		argStruct			= serializeJSON({ strKey=11 }),
		argTestObj			= serializeJSON(testOb),
		argTestSubObjArr	= serializeJSON(propertyTestSubObjArr)
	},
	methodArgumentsDefinition	= metadata.parameters
);

writeDump(new testWebService().doSomething(argumentcollection=deserializedArguments));
</cfscript>
