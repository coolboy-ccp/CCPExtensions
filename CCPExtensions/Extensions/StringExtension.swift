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
    
    func toData() -> Data? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data
    }
    
    func toDictionary() -> [String : Any] {
        guard let data = toData() else {
            return [String : Any]()
        }
        guard let dic = data.toDictionary() else {
            return [String : Any]()
        }
        return dic
    }
}

extension String {
    var base64: String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }

    var urlEncode: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}

extension String {
    var isMobile: Bool {
        let regex = "1[3|4|5|6|7|8|][0-9]{9}"
        return isValid(regex)
        
    }
    
    var isMail: Bool {
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return isValid(regex)
    }
    
    var isCarNo: Bool {
        let regex = "^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$"
        return isValid(regex)
    }
    
    //simple
    func simpleCheckIDCardNo() -> Bool {
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        return isValid(regex)
    }
    
    /** accurate
     * 身份证编码规则
     * 总长18位
     * 前六位为地址码(前二为省编码，中二为市，编码后二为区县编码)，按GB/T2260的规定执行
     * 7-14位为出生日期编码
     * 15-17位为顺序码，奇数分配给男性，偶数分配给女性
     * 18位为校验码，按照ISO 7064:1983.MOD 11-2校验码计算出来
     
     *** 计算方法
     1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2 ；
     2、将这17位数字和系数相乘的结果相加；
     3、用加出来和除以11，看余数是多少；
     4、余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2
     
     */
    
    func accurateCheckIDCardNo() -> Bool {
        if self.simpleCheckIDCardNo() {
            var sum = 0
            var lastChar = ""
            let rates = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]
            let numberStrings = ["1", "0", "X", "8", "9", "7", "6", "5", "4", "3", "2"];
            for (idx, element) in self.enumerated() {
                if idx == 17 {
                    lastChar = String(element)
                    break
                }
                if let num = Int(String(element)) {
                    sum += num * rates[idx]
                }
                else {
                    return false
                }
            }
            let remainder = sum % 11
            return numberStrings[remainder] == lastChar
        }
        return false
    }
    
    /** 银行卡号有效性（Luhn算法）
     * 16 位卡号校验位采用 Luhm 校验方法计算：
     * 1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
     * 2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
     * 3，将加法和加上校验位能被 10 整除。     
     */
    
    
    
    private func isValid(_ regex: String) -> Bool{
        let pre = NSPredicate(format: "SELF MATCHES %@", regex)
        return pre.evaluate(with:self)
    }
}
