trigger AccountTrigger on Account(after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        List<Contact> contactsTC = new List<Contact>();
        for (Account acc : Trigger.new) {
            if (acc.PrimaryContact__c == null) {
                Contact con = new Contact(AccountId = acc.Id, LastName = acc.Name, Phone = acc.Phone, Email = acc.Email__c);
                contactsTC.add(con);
            }
        }
        if (!contactsTC.isEmpty()) {
            insert contactsTC;
        }

        List<Account> accountsTU = new List<Account>();
        for (Contact con :contactsTC){
            Account acc = new Account(Id = con.AccountId, PrimaryContact__c = con.Id);
            accountsTU.add(acc);
        }
        if (!accountsTU.isEmpty()) {
            update accountsTU;
        }
    }
}