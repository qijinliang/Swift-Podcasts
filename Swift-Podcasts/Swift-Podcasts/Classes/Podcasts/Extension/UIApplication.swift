//
//  UIApplication.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/22.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainViewController? {
        
        return shared.keyWindow?.rootViewController as? MainViewController
    }
}

