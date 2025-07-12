import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        self.window = UIWindow(windowScene: windowScene)

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        let controller = BetsListViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.prefersLargeTitles = true

        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

}
