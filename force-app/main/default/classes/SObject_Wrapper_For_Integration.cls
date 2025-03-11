public with sharing class SObject_Wrapper_For_Integration {

	public boolean activateable;
	public boolean createable;
	public boolean custom       {get;set;}
	public boolean customSetting;
	public boolean deepCloneable;
	public boolean deletable;
	public boolean deprecatedAndHidden;
	public boolean feedEnabled;
	public boolean hasSubtypes;
	public boolean isInterface;
	public boolean isSubtype;
	public String keyPrefix;	//0Pp
	public String label;	//AI Application
	public String labelPlural;	//AI Applications
	public boolean layoutable;  
	public boolean mergeable;
	public boolean mruEnabled;
	public String name	          {get;set;}  //AIApplication     
	public boolean queryable;   
	public boolean replicateable;
	public boolean retrieveable;
	public boolean searchable;
	public boolean triggerable;
	public boolean undeletable;
	public boolean updateable;
	public cls_urls urls;

	class cls_urls {
		public String rowTemplate;	///services/data/v58.0/sobjects/AIApplication/{ID}
		public String describe;	///services/data/v58.0/sobjects/AIApplication/describe
		public String allSObjects;	///services/data/v58.0/sobjects/AIApplication
	}
}