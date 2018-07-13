//
//  ButtonExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

typealias ActionBlock = () -> Void

final class ClosureWrapper {
    let cb: ActionBlock
    init(_ callback: @escaping ActionBlock) {
        cb = callback
    }
    
    @objc func invoke() {
        cb()
    }
}

extension UIButton {
    /*
     the default frame is just for navigationItem
     */
    static func customButton(_ image: UIImage, action: @escaping ActionBlock, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 30)) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(image, for: UIControlState())
        button.frame = frame
        button.imageView!.contentMode = .scaleAspectFit
        button.add(action)
        return button
    }
    
    func add(_ action: @escaping ActionBlock, events: UIControlEvents = .touchUpInside) {
        let wrapper = ClosureWrapper(action)
        addTarget(wrapper, action: #selector(ClosureWrapper.invoke), for: events)
    }
}

extension UIButton {
    func setBackground(_ color: UIColor, state: UIControlState = .normal) {
        let img = color.toImage(CGSize(width: 1, height: 1))
        setBackgroundImage(img, for: state)
    }
}
