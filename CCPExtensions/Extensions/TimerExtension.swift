//
//  TimerExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension Timer {
    class func `repeat`(_ interval: TimeInterval, _ block: @escaping ActionBlock) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0, { (_) in
            block()
        })
    }
}
