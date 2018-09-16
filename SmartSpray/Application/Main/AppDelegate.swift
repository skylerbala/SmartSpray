//
//  AppDelegate.swift
//  ImageColorQuantization
//
//  Created by Skyler Bala on 9/3/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarVC = UITabBarController()

        let predictVC = PredictCoverageViewController()
        predictVC.title = "Predict"
        predictVC.tabBarItem = UITabBarItem(title: "Predict", image: #imageLiteral(resourceName: "icons8-calculator-50"), selectedImage: #imageLiteral(resourceName: "icons8-calculator-50"))

        
        let captureVC = CaptureViewController()
        captureVC.title = "Capture"
        captureVC.tabBarItem = UITabBarItem(title: "Capture", image: #imageLiteral(resourceName: "icons8-screenshot-50"), selectedImage: #imageLiteral(resourceName: "icons8-screenshot-50"))

        let predictionsListVC = PredictionsListViewController()
        predictionsListVC.title = "Predictions"
        predictionsListVC.tabBarItem = UITabBarItem(title: "Capture", image: #imageLiteral(resourceName: "icons8-menu-50"), selectedImage:#imageLiteral(resourceName: "icons8-menu-50"))

        let vcs = [predictVC, captureVC, predictionsListVC]

        tabBarVC.viewControllers = vcs.map({ (vc) -> UIViewController in
            let navController = UINavigationController(rootViewController: vc)
            return navController
        })
//        
//        
//        let cameraButton = UIButton()
//        cameraButton.setImage(#imageLiteral(resourceName: "camera-button"), for: UIControlState.normal)
//        cameraButton.sizeToFit()
//        cameraButton.translatesAutoresizingMaskIntoConstraints = false
//        tabBarVC.tabBar.addSubview(cameraButton)
//        tabBarVC.tabBar.centerXAnchor.constraint(equalTo: cameraButton.centerXAnchor).isActive = true
//        tabBarVC.tabBar.topAnchor.constraint(equalTo: cameraButton.centerYAnchor).isActive = true
//        
        window?.rootViewController = tabBarVC

        
        // tab bar always going to have logo
        // on the left of ttab bar we have an account login
        // we will use a uiscreen edge

//        let captureVC = CaptureViewController()
//        captureVC.title = "Capture"
//
//        let predictVC = PredictCoverageViewController()
//        predictVC.title = "Predict"
//
//        let predictionsListVC = PredictionsListViewController()
//        predictionsListVC.title = "Predictions"
//
//        let vcs = [captureVC, predictVC, predictionsListVC]
//        let navVCs = vcs.map({ (vc) -> UIViewController in
//            let navController = UINavigationController(rootViewController: vc)
//            let logoImageView = UIImageView(image: UIImage(named: "navBarLogo"))
//            logoImageView.contentMode = .scaleAspectFit
//
//            navController.navigationBar.topItem?.titleView = logoImageView
//
//            return navController
//        })
//
//        let mainContainerVC = MainContainerViewController.containerViewWith(leftVC: vcs[0], middleVC: vcs[1], rightVC: vcs[2])
//
//        window?.rootViewController = UINavigationController(rootViewController: mainContainerVC)

        
        window?.makeKeyAndVisible()
        
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
        let container = NSPersistentContainer(name: "ImageColorQuantization")
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

}

