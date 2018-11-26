//
//  Extensions.swift
//  ImgurSearch
//
//  Created by Jake Gray on 11/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
