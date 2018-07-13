//
//  ListTableExtension.swift
//  CCPExtensions
//
//  Created by 储诚鹏 on 2018/7/13.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//
//UITableView, UICollectionView

import UIKit

protocol CellRegisterable {
    associatedtype T
    func registerCellNib(_ cellClass: T.Type, block: (UINib, String) -> Void)
}

extension CellRegisterable {
    func registerCellNib(_ cellClass: T.Type, block: (UINib, String) -> Void) {
        let name = String(describing: cellClass)
        let nib = UINib(nibName: name, bundle: nil)
        block(nib, name)
    }
}

extension UITableView: CellRegisterable{
    typealias T = UITableViewCell
    //cellClass name must equal to xib name
    func registerCellNib<T: UITableViewCell>(_ cellClass: T.Type) {
        registerCellNib(cellClass) { (nib, identifier) in
            register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    func reusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        let name = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("🌹🌹🌹 [reusableCell]: \(name) isn't registed")
        }
        return cell
    }
}

extension UICollectionView: CellRegisterable {
    typealias T = UICollectionViewCell
    
    func registerCellNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        registerCellNib(cellClass) { (nib, identifier) in
            register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func resuableCell<R: UICollectionViewCell>(_ cellClass: R.Type, indexPath: IndexPath) -> R {
        let name = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: name, for: indexPath)
            as? R else {
                fatalError("🌹🌹🌹 [reusableCell]: \(name) isn't registed")
        }
        return cell
    }
}
