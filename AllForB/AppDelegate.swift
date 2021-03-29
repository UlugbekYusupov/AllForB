//
//  AppDelegate.swift
//  AllForB
//
//  Created by Mirzoulugbek Yusupov on 2021/02/26.
//

import UIKit
import CoreData
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func scheduleNotification(at date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Tutorial Reminder"
        content.body = "Just a reminder to read your tutorial over at appcoda.com!"
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LoginInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveLoginDataToCoreData(data: LoginData){
        let context: NSManagedObjectContext = self.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "LoginInfo", in: context)!
        let mngdObj: NSManagedObject = NSManagedObject(entity: entity, insertInto: context)
        
        mngdObj.setValue(data.LoginToken, forKeyPath: "loginToken")
        mngdObj.setValue(data.UserId, forKeyPath: "userId")
        mngdObj.setValue(data.AccountId, forKey: "accountId")
        mngdObj.setValue(data.ExceptionMessage, forKey: "exceptionMessage")
        mngdObj.setValue(data.PersonId, forKey: "personId")
        mngdObj.setValue(data.NewExpireDateTime, forKey: "newExpireDateTime")
        mngdObj.setValue(data.ReturnCode, forKey: "returnCode")
        mngdObj.setValue(data.ThrownException, forKey: "thrownException")
                 
        do {
            try context.save(); print("LoginData has been saved to CoreData")
        }
        catch {
            print("An error has occurred: \(error.localizedDescription)")
            
        }
        let currentLoginToken = data.LoginToken
        mngdObj.setValue(currentLoginToken, forKeyPath: "loginToken")
        self.saveCurrentLoginToken(currentLoginToken!)
    }
    
    func saveCurrentLoginToken(_ token:String){
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "currentLoginToken")
        defaults.synchronize()
        print("Successfully saved the current login token...")
    }
    
    func getCurrentLoginToken() -> String? {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "currentLoginToken") as? String
        if token != nil {
            return token!
        }
        else {
            return nil
        }
    }
    
    func getAnyValueFromCoreData(_ loginToken:String,_ key:String) -> Any? { // key = data you want to retrieve the value of

        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDel.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "LoginInfo")
        fetchReq.predicate = NSPredicate(format: "loginToken==%@",loginToken)
        
        var anyVal: Any?
        
        do {
            let result = try context.fetch(fetchReq)
            for data in result {
                let val = data.value(forKey: key)
                if val != nil {
                    anyVal = val!
                }
                else {
                    anyVal = nil
                }
            }
        }
        
        catch {
            anyVal = nil // Set value to nil in case of error (not always recommended)
            print("An error has occurred: \(error.localizedDescription)")
        }
        return anyVal
    }
    
    func getReturnCode() -> Int? {
         let token = getCurrentLoginToken() // retrieve from UserDefaults
         let returnCode = getAnyValueFromCoreData(token!,"returnCode") as? Int
         return returnCode
    }
    
    public func clearDatabase() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }

        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

         do {
            try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch let error {
             print("Attempted to clear persistent store: " + error.localizedDescription)
            }
        }
}
