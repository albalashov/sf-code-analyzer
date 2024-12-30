public with sharing class SOQLController {

  public String name {

      get { return name;}

      set { name = value;}

  }

  public PageReference query() {

      String queryName = '%' + name + '%';

      if (Schema.sObjectType.Contact.isAccessible()) {
          List<Contact> queryResult = [SELECT Id FROM Contact WHERE (IsDeleted = false and Name like :queryName)];
          System.debug('query result is ' + queryResult);
      } else {
          // Handle lack of permission gracefully
          throw new CustomException('You do not have permission to access ContentVersion records.');
      }

      return null;
  }
}

// Vulnerable code
//public class SOQLController {
//    public String name {
//        get { return name;}
//
//        set { name = value;}
//    }
//
//    public PageReference query() {
//
//        String qryString = 'SELECT Id FROM Contact WHERE (IsDeleted = false and Name like \'%' + name + '%\')';
//
//        List<Contact> queryResult = Database.query(qryString);
//
//        System.debug('query result is ' + queryResult);
//
//        return null;
//    }
//}
