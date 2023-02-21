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
        view.backgroundColor = .purple

        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
