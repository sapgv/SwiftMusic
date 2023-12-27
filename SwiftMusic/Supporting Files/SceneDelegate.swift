//
//  SceneDelegate.swift
//  SwiftMusic
//
//  Created by Grigory Sapogov on 27.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = self.createViewController()
        window.makeKeyAndVisible()
        
        self.window = window

    }

    private func createViewController() -> UIViewController {
        
        let viewModel = ViewModel()
        let viewController = ViewController()
        viewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
        
    }

}

