//
//  ImageExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UIImage {
    
    public enum ResizeMode {
        case fill, fit, aspectFill
    }
    
    func to(_ targetSize: CGSize, mode: ResizeMode = .fill) -> UIImage? {
        let ts = CGSize(width: targetSize.width * scale, height: targetSize.height * scale)
        let horizontalRatio = ts.width / self.size.width;
        let verticalRatio = ts.height / self.size.height;
        var ratio: CGFloat
        switch mode {
        case .fit:
            ratio = min(horizontalRatio, verticalRatio)
        case .aspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        default:
            ratio = 1
        }
        let rect = CGRect(x: 0, y: 0, width: ts.width * ratio, height: ts.height * ratio)
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: rect)
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg
    }
}

