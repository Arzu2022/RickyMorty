
import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        let vc1 = HomeViewController()
        let vc2 = SearchVC()
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "mainColor")
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .systemCyan
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        vc1.title = "Home"
        vc2.title = "Search"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        self.selectedIndex = 1
        self.setViewControllers([vc1,vc2], animated: true)
    }
    
}
