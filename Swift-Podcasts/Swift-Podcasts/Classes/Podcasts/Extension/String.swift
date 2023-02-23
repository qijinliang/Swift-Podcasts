//
//  String.swift
//  Swift-Podcasts
//
//  Created by Cheney on 2023/2/22.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
