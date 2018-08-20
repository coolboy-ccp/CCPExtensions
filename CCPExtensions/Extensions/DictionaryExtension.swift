//
//  DictionaryExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/8/20.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import Foundation


extension Dictionary {
    func toData() -> Data? {
        if !JSONSerialization.isValidJSONObject(self) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return data
    }
    
    func toJson() -> String {
        guard let data = toData() else {
            return ""
        }
        guard let str = data.toString()  else {
            return ""
        }
        return str
    }
}
