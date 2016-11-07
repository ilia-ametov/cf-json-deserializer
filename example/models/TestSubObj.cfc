component accessors="true" {
	
	
	property name="propertyNumeric"		type="numeric"	required="true"	serializable="true" getter="true" setter="true";
	property name="propertyString"		type="string"	required="true"	serializable="true" getter="true" setter="true";
	property name="propertyBoolean"		type="boolean"	required="true" serializable="true" getter="true" setter="true";
	property name="propertyDate"		type="date"		required="true" serializable="true" getter="true" setter="true";
	property name="propertyArray"		type="array"	required="true" serializable="true" getter="true" setter="true";
	property name="propertyStruct"		type="struct"	required="true" serializable="true" getter="true" setter="true";
	
	
	public TestSubObj function init(
		numeric		propertyNumeric,
		string		propertyString,
		boolean		propertyBoolean,
		date		propertyDate,
		array		propertyArray,
		struct		propertyStruct
	) {
		setPropertyNumeric(arguments.propertyNumeric);
		setPropertyString(arguments.propertyString);
		setPropertyBoolean(arguments.propertyBoolean);
		setPropertyDate(arguments.propertyDate);
		setPropertyArray(arguments.propertyArray);
		setPropertyStruct(arguments.propertyStruct);
		
		return this;
	}
	
	
}