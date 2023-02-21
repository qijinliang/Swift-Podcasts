//
//  MainViewController.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/21.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
        
        let layout = UICollectionViewFlowLayout()
        
        let favortesController = UIViewController()
        viewControllers = [
            generateNavigationController(for: PodcastsSearchController(), title: "搜索", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(for: PodcastsSearchController(), title: "收藏", image: #imageLiteral(resourceName: "heart")),
            generateNavigationController(for: PodcastsSearchController(), title: "下载", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image
        
        return navController
    }

}
