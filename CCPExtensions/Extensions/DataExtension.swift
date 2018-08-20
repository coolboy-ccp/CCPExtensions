//
//  DataExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/8/20.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension Data {
    func toDictionary() -> [String : Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)
        guard let result = json as? [String : Any] else {
            return nil
        }
        return result
    }
    
    func toString() -> String? {
        guard let result = String(data: self, encoding: .utf8) else {
            return nil
        }
        return result
    }
}
