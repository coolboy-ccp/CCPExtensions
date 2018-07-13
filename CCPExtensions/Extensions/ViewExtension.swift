//
//  ViewExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UIView {
    var width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    
    var height: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.bounds.height
        }
    }
    
    var x: CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.minX
        }
    }
    
    var y: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get  {
            return self.frame.minY
        }
    }
    
    var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    var cY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    var cX: CGFloat {
        get {
            return self.center.x
            
        }
        set {
            self.center.x = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.y = newValue - self.height
        }
    }
    
    var right: CGFloat {
        set {
            self.x = newValue - self.width
        }
        get {
            return self.frame.maxX
        }
    }
}
