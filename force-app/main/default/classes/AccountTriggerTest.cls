@isTest
public class AccountTriggerTest {
    static final String PHONE_NUMBER = '123645';
    static final String EMAIL = 'test@mail.com';

    @isTest
    static void afterInsert() {
        Account acc = new Account(Name = 'Test', Phone = PHONE_NUMBER, Email__c = EMAIL);

        Test.startTest();
        insert acc;
        Test.stopTest();

        Contact con = [SELECT Phone, Email, AccountId FROM Contact LIMIT 1];
        acc = [SELECT Phone, Email__c, PrimaryContact__c FROM Account WHERE Id = :acc.Id];

        Assert.areEqual(con.Id, acc.PrimaryContact__c);
        Assert.areEqual(acc.Id, con.AccountId);
        Assert.areEqual(PHONE_NUMBER, con.Phone);
        Assert.areEqual(EMAIL, con.Email);
    }
}