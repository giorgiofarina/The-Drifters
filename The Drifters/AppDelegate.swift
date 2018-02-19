//
//  AppDelegate.swift
//  The Drifters
//
//  Created by Graziella Caputo on 01/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

// *** DIZIONARIO DI FILTRI
var filtri = [String: Any]()

// *** DISPATCH GROUP per il caricamento asincrono dei dati
let group = DispatchGroup()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    //TUTORIAL FUNCTION. MAKE IT APPEAR ONLY AT THE FIRST ACCESS
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        var viewController: UIViewController!
        
       
        
        checkDataStore()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "The_Drifters")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // Check if there are already stored data
    
    func checkDataStore(){
        let plantRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plant")
        let listRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let plantCount = try context.count(for: plantRequest)
            let listCount = try context.count(for: listRequest)
            print("Piante già presenti: \(plantCount)")
            print("Liste già presenti: \(listCount)")
            
            if plantCount == 0 && listCount == 0{
                
                group.enter()
                DispatchQueue.main.async {
                    self.uploadData()
                    group.leave()
                }
            }
            
        }
        catch {
            print(error)
        }
    }
    
    // Upload data from .json file
    
    func uploadData() {
        // * Nome file .json
        let resource = "data"
        
        let resourceExtension = "json"
        let url = Bundle.main.url(forResource: resource, withExtension: resourceExtension)
        
        do {
            
            let data = try Data.init(contentsOf: url!)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
            
            // * Nome array "---" in .json
            let jsonPlantArray = jsonResult["plant"] as? [[String: AnyObject]]
            let jsonListArray = jsonResult["list"] as? [[String: AnyObject]]
            
            for json in jsonPlantArray! {
                let plant = NSEntityDescription.insertNewObject(forEntityName: "Plant", into: context) as! Plant
                
                // * campo CoreData uguagliato a campo di ogni elemento in .json
                plant.commonName = json["commonName"] as? String
                plant.scientificName = json["scientificName"] as? String
                
                // * immagine
                let imageName = json["img1"] as? String
                let image = UIImage(named: imageName!)
                let imageData = UIImageJPEGRepresentation(image!, 1.0)
                plant.img1 = imageData as NSData?
            }
            
            for json in jsonListArray! {
                let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: context) as! List
                list.listName = json["listName"] as? String
            }
            
            appDelegate.saveContext()
            
            let plantRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plant")
            let listRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
            do {
                let plantCount = try context.count(for: plantRequest)
                let listCount = try context.count(for: listRequest)
                print("Piante caricate: \(plantCount)")
                print("Liste caricate: \(listCount)")
            }
            catch {
                print("Errore nel conteggio dopo il caricamento!")
            }
        }
        catch {
            print("Errore nel caricamento dei dati")
        }
    }


    
    
    
}


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
