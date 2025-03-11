public class MyController {
    public String selectedObject { get; set; }
    public String selectedField { get; set; }
    
    // Map to hold object names and their fields
    public Map<String, List<String>> objectFieldsMap { get; set; }

    public MyController() {
        objectFieldsMap = new Map<String, List<String>>();
        loadObjectFields();
    }

    // Method to load object names and fields
    private void loadObjectFields() {
        // Example: Adding fields for the Account and Contact objects
        objectFieldsMap.put('Account', new List<String>{'Name', 'Industry', 'AnnualRevenue'});
        objectFieldsMap.put('Contact', new List<String>{'FirstName', 'LastName', 'Email'});
    }

    public List<SelectOption> getObjectOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for (String objName : objectFieldsMap.keySet()) {
            options.add(new SelectOption(objName, objName));
        }
        return options;
    }

    public List<SelectOption> getFieldOptions() {
        List<SelectOption> options = new List<SelectOption>();
        if (objectFieldsMap.containsKey(selectedObject)) {
            for (String field : objectFieldsMap.get(selectedObject)) {
                options.add(new SelectOption(field, field));
            }
        }
        return options;
    }

    public void submit() {
        // Logic to handle the selected object and field
        System.debug('Selected Object: ' + selectedObject);
        System.debug('Selected Field: ' + selectedField);
    }
}