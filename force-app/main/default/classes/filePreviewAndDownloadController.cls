public with sharing class filePreviewAndDownloadController {

    @AuraEnabled(cacheable=true)
    public static Map<Id, String> getRelatedFilesByRecordId(String recordId){
        try {
            // Returns the files which are related to Account whose Id is passed.
            List<ContentDocumentLink> files = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: recordId];

            List<Id> fileIds = new List<Id>();
            for(ContentDocumentLink link: files){
                fileIds.add(link.ContentDocumentId);
            }

            List<ContentVersion> docs = [SELECT Id, ContentDocumentId, ContentSize, FileType, Title, FileExtension FROM ContentVersion WHERE 
            ContentDocumentId IN : fileIds];    

            Map<Id, String> mapIdTitle = new Map<Id, String>();
            for(ContentVersion cv : docs){
                mapIdTitle.put(cv.ContentDocumentId, cv.Title);
            }
            return mapIdTitle;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static String deleteFilesById(String fileToDelete) {
        try {
            // Query the ContentDocument ID associated with the file
            ContentDocument document = [
                SELECT Id
                FROM ContentDocument
                WHERE Id = :fileToDelete
                LIMIT 1
            ];

            if (document != null) {
                delete document; // Deleting ContentDocument
                return 'File Deleted Successfully !!';
            } 
            else {
                return 'File not found.';
            }
        }
        catch (System.LimitException le) {
            // Handle specific limit exception
            throw new AuraHandledException('DML Limit exceeded: ' + le.getMessage());
        } 
        catch (Exception e) {
            // Handle other exceptions
            throw new AuraHandledException('Error deleting file: ' + e.getMessage());
        }
    }

}