//
//  LoginInfo+CoreDataProperties.swift
//  
//
//  Created by Mirzoulugbek Yusupov on 2021/03/08.
//
//

import Foundation
import CoreData


extension LoginInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginInfo> {
        return NSFetchRequest<LoginInfo>(entityName: "LoginInfo")
    } 

    @NSManaged public var loginToken: String?
    @NSManaged public var userId: Int64
    @NSManaged public var personId: Int64
    @NSManaged public var accountId: String?
    @NSManaged public var newExpireDateTime: String?
    @NSManaged public var returnCode: Int64
    @NSManaged public var exceptionMessage: String?
    @NSManaged public var thrownException: String?

}
