//
//  UIApplication.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/22.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainViewController? {
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let mainController = keyWindow?.rootViewController as? MainViewController
        return mainController
    }
}

