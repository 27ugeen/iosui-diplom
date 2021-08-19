//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by GiN Eugene on 18.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        
        let tabBarController = UITabBarController()
        
        let habitsVC = HabitsViewController()
        habitsVC.title = "Привычки"
        let InfoVC = InfoViewController()
        InfoVC.title = "Информация"
        
        let habitsNavVC = UINavigationController(rootViewController: habitsVC)
        habitsNavVC.tabBarItem = UITabBarItem(title: habitsNavVC.title, image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        
        let InfoNavVC = UINavigationController(rootViewController: InfoVC)
        InfoNavVC.tabBarItem = UITabBarItem(title: InfoNavVC.title, image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        tabBarController.viewControllers = [habitsNavVC, InfoNavVC]
        
        window?.rootViewController = tabBarController
    }
}

