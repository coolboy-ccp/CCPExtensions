//
//  StringExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit


extension String {
    //给定宽度和字体大小获取高度
    func adaptSize(_ limitWidth: CGFloat, _ font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: limitWidth, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        return boundingBox.size
    }
}
