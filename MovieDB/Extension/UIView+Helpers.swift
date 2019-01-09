//
//  UIView+Helpers.swift
//  MovieDB
//
//  Created by Link Chang on 2019/1/9.
//  Copyright © 2019 Link. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}
