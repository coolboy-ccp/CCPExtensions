//
//  ViewControllerExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UIViewController {
    func back(_ image: UIImage = UIImage()) {
        navigationItem.left(image) { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    static func fromXib<T: UIViewController>() -> T {
        let name = String(describing: self)
        return self.init(nibName: name, bundle: nil) as! T
    }
    
    func skipTo(_ vc: UIViewController, _ animation: Bool = true, _ completion: (() -> Void)? = nil) {
        if let nav = self.navigationController {
            vc.hidesBottomBarWhenPushed = true
            nav.pushViewController(vc, animated: animation)
        }
        else {
            self.present(vc, animated: animation, completion: completion)
        }
    }
}
