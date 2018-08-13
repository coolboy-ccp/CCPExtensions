//
//  DateExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension Date {
    static var week: String {
        let components = Calendar.current.dateComponents([.weekday], from: Date())
        guard let weekday = components.weekday else { return "当前日期不存在星期选项" }
        let weekStrings = ["如果从0开始说明苹果的api有变化", "周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        return weekStrings[weekday]
    }
    
    func timeAgoSinceNow() -> String {
        let now = Date()
        let ealier = (self as NSDate).earlierDate(now)
        let isEalier = ealier == self
        if isEalier {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second, .weekday], from: self, to: now)
            if let year = components.year, year > 0 {
                if year > 1 {
                    return "\(year) 年前"
                }
                return "去年"
            }
            if let month = components.month, month > 0 {
                if month > 1 {
                    return "\(month) 月前"
                }
                return "上月"
            }
            if let week = components.weekOfYear, week > 0 {
                if week > 1 {
                    return "\(week) 周前"
                }
                return "上周"
            }
            if let day = components.day, day > 0 {
                if day > 1 {
                    return "\(day) 天前"
                }
                return "昨天"
            }
            if let hour = components.hour, hour > 0 {
                return "\(hour) 小时前"
            }
            if let minute = components.minute, minute > 0 {
                return "\(minute) 分钟前"
            }
            if let second = components.second, second > 0 {
                return "\(second) 秒前"
            }
            return "刚刚"
        }
        
        return "给定的时间晚于当前时间"
    }
    
    static func thisWeekDays() -> [Date] {
        let date = Date()
        let calendar = Calendar.current
        let componets = calendar.dateComponents([.year, .month, .weekday, .day, .hour, .minute, .second], from: date)
        let dates = (0 ... 6).map { (idx) -> Date in
            var varComponents = componets
            let offset = idx - componets.weekday! + 1
            varComponents.day! += offset
            return (calendar.date(from: varComponents)!)
        }
        return dates
    }
    
    func zeroPoint() -> Date {
        let timeInval = Int(self.timeIntervalSince1970) / (24 * 3600) * (24 * 3600)
        return Date(timeIntervalSince1970: Double(timeInval))
    }
    
    func latestPoint() -> Date {
        let timeInval = zeroPoint().timeIntervalSince1970 + 24 * 3600 - 1
        return Date(timeIntervalSince1970: Double(timeInval))
    }
}


extension Date {
    /**
     1、如果是列表的第一项，则显示时间；
     2、如果这一条与前面一条间隔两分钟以上，则显示时间
     3、如果这一条是列表的第一项，但是下拉刷新后与前面一条间隔在两分钟之内，仍显示这一条的时间
     4、时间显示格式：
     a) 如果是今天的聊天，显示具体时间。如：11:05
     b) 如果是昨天，或者前天，显示相对日期和具体时间，如：昨天 19:34，前天 20:22
     c) 如果在七天之内，则显示 星期加时间，如：周二 12:23
     d) 如果在一年之内，则显示月份日期 和时间，如：7月18日 12:34
     e) 一年以上的，显示年月日 加时间，如： 2014年6月29日 8:20
     */
    
    var timeString: String? {
        let calendar = Calendar.current
        let now = Date()
        let componentsSet: Set<Calendar.Component> = [.year, .month, .weekday, .day, .hour, .minute, .second]
        let nowComponents = calendar.dateComponents(componentsSet, from: now)
        let targetComponents = calendar.dateComponents(componentsSet, from: self)
        let year = nowComponents.year! - targetComponents.year!
        let month = nowComponents.month! - targetComponents.month!
        let day = nowComponents.day! - targetComponents.day!
        
        if year != 0 {
            return String(format: "%zd年%zd月%zd日 %02d:%02d", targetComponents.year!, targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
        }
        if (month > 0 || day > 7) {
            return String(format: "%zd月%zd日 %02d:%02d", targetComponents.month!, targetComponents.day!, targetComponents.hour!, targetComponents.minute!)
        } else if (day > 2) {
            return String(format: "%@ %02d:%02d",Date.week, targetComponents.hour!, targetComponents.minute!)
        } else if (day == 2) {
            if targetComponents.hour! < 12 {
                return String(format: "前天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else if targetComponents.hour == 12 {
                return String(format: "前天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else {
                return String(format: "前天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
            }
        } else if (day == 1) {
            if targetComponents.hour! < 12 {
                return String(format: "昨天上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else if targetComponents.hour == 12 {
                return String(format: "昨天下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else {
                return String(format: "昨天下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
            }
        } else if (day == 0){
            if targetComponents.hour! < 12 {
                return String(format: "上午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else if targetComponents.hour == 12 {
                return String(format: "下午 %02d:%02d",targetComponents.hour!, targetComponents.minute!)
            } else {
                return String(format: "下午 %02d:%02d",targetComponents.hour! - 12, targetComponents.minute!)
            }
        } else {
            return ""
        }
    }
}
