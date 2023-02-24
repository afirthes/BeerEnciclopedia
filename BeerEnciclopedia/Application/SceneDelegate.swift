//
//  SceneDelegate.swift
//  BeerEnciclopedia
//
//  Created by Afir Thes on 24.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: BeerListViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
