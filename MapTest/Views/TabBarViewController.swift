//
//  TabBarViewController.swift
//  MapTest
//
//  Created by Никита Попов on 22.03.23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarViewSettings()
        visualTabBarSettings()

    }
//MARK: - basic tabBar settings
    private func tabBarViewSettings(){
        viewControllers = [createNavVC(vc: MapViewController(), imageName: "mappin.and.ellipse", title: "Location"),
                           createNavVC(vc: SaveDataViewController(), imageName: "mappin", title: "Save Points")
        ]
    }
 
//MARK: - func create navigation Controller
    private func createNavVC(vc:UIViewController, imageName:String, title:String) -> UINavigationController{
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(systemName: imageName)
        let navController = UINavigationController(rootViewController: vc)
        
        return navController
    }
    
    //MARK: - visual tabBar settings
    private func visualTabBarSettings(){
        self.tabBar.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.3458712748)
    }
}
