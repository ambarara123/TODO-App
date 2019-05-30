//
//  AppDelegate.swift
//  TODO App
//
//  Created by Ambar Kumar on 24/05/19.
//  Copyright © 2019 Ambar Kumar. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("did finish launching with option")
        
   //     print(Realm.Configuration.defaultConfiguration.fileURL)
       
        
        do{
            let realm = try Realm()
          
        }catch{
            print("error initialising realm \(error)")
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
        print("enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    // MARK: - Core Data stack
  
}

