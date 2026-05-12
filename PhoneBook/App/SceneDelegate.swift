import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // SceneDelegate.swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let dependencies = AppDependencies.live()
        let viewModel = UserListViewModel(repository: dependencies.userRepository)
        let viewController = UserListViewController(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}
