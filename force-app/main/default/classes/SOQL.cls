/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Blanche
 */

 public with sharing class SOQL {
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads(){
        return [SELECT Id, LastName, Company, Phone, Email
                FROM Lead];
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName(String firstName){
        return [SELECT Id, Name
                FROM Contact
                WHERE FirstName = :firstName];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName() {
        List<Contact> contacts = [
            SELECT Id 
            FROM Contact 
            WHERE LastName IN ('Smith', 'Jones')
            ];

        List<Id> contactIds = new List<Id>();
        for (Contact contactSmithOrJones : contacts) {
            contactIds.add(contactSmithOrJones.Id);
        }

        return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunitiesByAccount(String accountId) {
        return [SELECT Id, Name, StageName, Amount, CloseDate, AccountId 
                FROM Opportunity 
                WHERE AccountId = :accountId AND StageName = 'Closed Won'];
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount() {
        return [SELECT COUNT() 
                FROM Account];
        }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek() {
        List<Task> tasks = [SELECT Id, Subject, ActivityDate 
                            FROM Task 
                            WHERE ActivityDate >= :Date.today() AND ActivityDate <= :Date.today().addDays(7)];

        Map<Id, Task> taskMap = new Map<Id, Task>();
        for (Task tasksDue : tasks) {
            taskMap.put(tasksDue.Id, tasksDue);
        }

        return taskMap;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain(String domain) {
        string emailPattern = '%@' + domain;
        return [SELECT id, Name, Email 
                FROM Contact 
                WHERE Email LIKE :emailPattern];
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String searchKeyword = '%'+ keyword + '%';
        return [SELECT Id, Name 
                FROM Opportunity 
                WHERE Name LIKE :searchKeyword]; 
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {       
        return [SELECT Id, CaseNumber, Origin, Status
                FROM Case
                WHERE Origin !='Web' AND ORIGIN !='EMAIL' AND Origin != '']; 
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
        String searchKeyword = '%'+ keyword + '%';
        return [SELECT Id, LastName, Company, Phone, Email, LeadSource, Title
                FROM Lead
                WHERE (LeadSource = :leadSource OR Title LIKE :searchKeyword)];
    }

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        List<Contact> contacts = [SELECT Id, LastName 
                                  FROM Contact 
                                  WHERE AccountId = :accountId];
            
        List<String> contactLastNames = new List<String>();
        for (Contact contact : contacts) {
            contactLastNames.add(contact.LastName);
    }

        return contactLastNames;
}

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult[] results = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage OR Amount > 10000
            ];

        Decimal totalRevenue = (Decimal)results[0].get('totalRevenue');

        return totalRevenue != null ? totalRevenue : 0;
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return [SELECT Id, Name 
                FROM Account
                ORDER BY Name 
                LIMIT 10];      
    }

    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return [SELECT Id, Amount, CloseDate, Name
                FROM Opportunity
                WHERE Amount > 100000
                ORDER BY CloseDate
                LIMIT 5];
    }

    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return [SELECT Id, FirstName, LastName, Birthdate
                FROM Contact
                WHERE Birthdate != NULL
                ORDER BY Birthdate DESC
                LIMIT 3]; 
    }

    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        return [SELECT Id, CaseNumber, Status, CreatedDate
                FROM Case
                WHERE Status = 'Open'
                ORDER BY CreatedDate ASC
                LIMIT 10 OFFSET 5];
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        Set<Id> caseIds = new Set<Id>();

        List<Case> cases = [SELECT Id
                            FROM Case
                            WHERE AccountId = :accountId];

        for (Case findCase : cases) {
            caseIds.add(findCase.Id);
        }

        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        List<Account> accounts = [SELECT Id, Name
                                  FROM Account
                                  WHERE BillingCountry != :country];

        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }

        return accountIdsToNames; 
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact contact = [SELECT Account.Name 
                           FROM Contact 
                           WHERE Id = :contactId LIMIT 1];

        return contact.Account.Name;
    }
    

/**
 * Question 20
 * Returns single Account that has related opportunities in the same query
 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
 * @param accountId The ID of the Account.
 * @return An Account record with related Opportunities.
 */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        return [SELECT Id, Name, 
                (SELECT Id, Name, StageName, Amount, CloseDate FROM Opportunities) 
                FROM Account 
                WHERE Id = :accountId];
}

/**
 * Question 21
 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
 * @param Account Id
 * @return List of contacts with the same Mailing State as the Account Billing State
 */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        Account accountBillingState = [SELECT Id, BillingState
                                       FROM Account
                                       WHERE Id = :accountId];

    String billingState = accountBillingState.BillingState;

    List<Contact> matchingContacts = [SELECT Id, Name, MailingState, AccountId
                                      FROM Contact
                                      WHERE MailingState = :billingState];

    return matchingContacts; 
}

/**
 * Question 22
 * Extracts email domains from them leads, then finds Accounts with matching website domains
 * If Lead Email = test@test.com return account with website = www.test.com
 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
 * @param A set of Lead Ids.
 * @return A list of Accounts with matching email domains.
 */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
    // Get email domains from Leads
    Map<String, String> leadDomains = new Map<String, String>();
    for (Lead lead : [SELECT Id, Email 
                      FROM Lead 
                      WHERE Id IN :leadIds]) {

        if (lead.Email != null && lead.Email.contains('@')) {
            String domain = lead.Email.split('@')[1].toLowerCase(); // Convert to lowercase
            leadDomains.put(lead.Id, domain);
        }
    }
        if (leadDomains.isEmpty()) {
        return new List<Account>();
    }
    List<Account> matchingAccounts = new List<Account>();
    for (Account account : [SELECT Id, Name, Website 
                            FROM Account 
                            WHERE Website != null]) {

        String normalizedWebsite = account.Website.toLowerCase().replace('www.', ''); // Strip "www."
        if (leadDomains.values().contains(normalizedWebsite)) {
            matchingAccounts.add(account);
        }
    }
    return matchingAccounts;
}

/**
 * Question 23
 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
 * Adds a randomized number between 1 to 3 to the quantity of each line item.
 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
 * @param Original Opportunity Id
 * @param List of cloned Opportunity Ids
 */
public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {

    List<OpportunityLineItem> origOppLineItems = [SELECT Id, Name, OpportunityId, Quantity, PricebookEntryId, UnitPrice
                                                  FROM OpportunityLineItem
                                                  WHERE OpportunityId = :origOppId];

    List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
    
    Integer randomNumber = Integer.valueOf(Math.floor(Math.random() * 3).intValue()) + 1;
    
    for (id cloneOppId : cloneOppIds) {
        for (OpportunityLineItem origLineItem : origOppLineItems) { 
            OpportunityLineItem newLineItem = origLineItem.clone(false, true);
            newLineItem.OpportunityId = cloneOppId;
            newLineItem.Quantity = newLineItem.Quantity + randomNumber;
            newLineItems.add(newLineItem);
        }
    }
    
    insert newLineItems;
}

/**
 * Question 24
 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
 * @return A list of filtered Opportunity
 */
public static List<Opportunity> getOpportunityDetailsForClosedWon() {
    return [SELECT Id, Name, Account.Name, Owner.Name
            FROM Opportunity
            WHERE StageName = 'Closed Won']; 
}

/**
 * Question 25
 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
 */
public static void setPrimaryContact() {
    
    Set<Id> accountIds = new Set<Id>();
    
    List<Opportunity> closedWonOpportunities = getOpportunityDetailsForClosedWon();
    
    for (Opportunity opp : closedWonOpportunities) {
        accountIds.add(opp.AccountId);
    }
    
    List<Contact> contacts = [SELECT Id, FirstName, AccountId
                              FROM Contact
                              WHERE AccountId IN :accountIds
                              ORDER BY FirstName ASC];

    Map<Id, Contact> accountContactsMap = new Map<Id, Contact>();
    
    for (Contact con : contacts) {
        if (!accountContactsMap.containsKey(con.AccountId)) {
            accountContactsMap.put(con.AccountId, con);
        }
    }
    
    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    
    for (Opportunity opp : closedWonOpportunities) {
        if (accountContactsMap.containsKey(opp.AccountId)) {
            opp.Primary_Contact__c = accountContactsMap.get(opp.AccountId).Id;
            opportunitiesToUpdate.add(opp);
        }
    }
    
    update opportunitiesToUpdate;
}
}

