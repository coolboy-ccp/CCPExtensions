//
//  NavigationExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UINavigationItem {
    private func toItems(contentAlignment: UIControlContentHorizontalAlignment = .left, image: UIImage, action: @escaping ActionBlock) -> [UIBarButtonItem] {
        let button = UIButton.customButton(image, action: action)
        button.contentHorizontalAlignment = contentAlignment
        let barItem = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        gapItem.width = -7
        return [gapItem, barItem]
    }
    
    func left(_ image: UIImage, action: @escaping ActionBlock) {
        leftBarButtonItems = toItems(image: image, action: action)
    }
    
    func right(_ image: UIImage, action: @escaping ActionBlock) {
        rightBarButtonItems = toItems(image: image, action: action)
    }
}
