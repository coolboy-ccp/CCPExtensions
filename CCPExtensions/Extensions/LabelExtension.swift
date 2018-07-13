//
//  LabelExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UILabel {
    func adaptFrame(_ limitWidth: CGFloat) {
        guard let text = text else {
            return
        }
        let size = text.adaptSize(limitWidth, font)
        frame.size.width = size.width
        frame.size.height = size.height
    }
}
