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
    
    static func fromXib<T: UIViewController>(_ vcClass: T.Type) -> T {
        let name = String(describing: vcClass)
        let vc = T(nibName: name, bundle: nil)
        return vc
    }
    
}
