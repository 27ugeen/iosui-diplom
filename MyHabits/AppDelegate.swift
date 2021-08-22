//
//  AppDelegate.swift
//  MyHabits
//
//  Created by GiN Eugene on 18.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//        var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        window?.backgroundColor = .systemRed
        
//        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
//        let navVC = UINavigationController(rootViewController: CatalogueViewController())
        
//        let tabBarController = UITabBarController()
        
        UITabBar.appearance().tintColor = UIColor(rgb: 0xA116CC)
//        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
        
//        let habitsVC = HabitsViewController()
//        habitsVC.title = "Привычки"
//        let InfoVC = InfoViewController()
//        InfoVC.title = "Информация"
//
//        let habitsNavVC = UINavigationController(rootViewController: habitsVC)
//        habitsNavVC.tabBarItem = UITabBarItem(title: habitsNavVC.title, image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
//
//        let InfoNavVC = UINavigationController(rootViewController: InfoVC)
//        InfoNavVC.tabBarItem = UITabBarItem(title: InfoNavVC.title, image: UIImage(systemName: "info.circle.fill"), tag: 1)
//
//        tabBarController.viewControllers = [habitsNavVC, InfoNavVC]
//
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
//
    
        return true
    }
    
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
}

