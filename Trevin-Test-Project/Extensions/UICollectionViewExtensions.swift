//
//  UICollectionView+Utility.swift
//  Scene
//
//  Created by Trevin Wisaksana on 21/01/2018.
//  Copyright © 2018 Trevin Wisaksana. All rights reserved.
//

import Foundation
import UIKit

protocol CellIdentifiable: class {
    static var cellIdentifier: String { get }
}

protocol ReusableViewIdentifiable: class {
    static var identifier: String { get }
}

extension CellIdentifiable where Self: UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }

}

extension ReusableViewIdentifiable where Self: UICollectionReusableView {
    
    static var identifer: String {
        return String(describing: self)
    }
    
}

extension UICollectionViewCell: CellIdentifiable { }

extension UICollectionReusableView: ReusableViewIdentifiable {
    
    static var identifier: String {
        return self.identifer
    }
    
}

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error dequeuing cell for identifier \(T.identifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifer, for: indexPath) as? T else {
            fatalError("Error dequeuing reusable view for identifier \(T.identifer)")
        }
        
        return supplementaryView
    }
    
    func register<T: UICollectionViewCell>(nib: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: T.cellIdentifier)
    }
    
    func register<T: UICollectionReusableView>(reusableView: T.Type, forSupplementaryViewOfKind kind: String) {
        register(reusableView, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifer)
    }
    
}

extension UICollectionView {
    
    func setInstruction() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: self.bounds.size.height))
        messageLabel.text = "Tap the search bar above to search for movies."
        messageLabel.textColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        self.backgroundView = messageLabel
    }
    
    func setEmptyMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = "Your search has shown no results."
        messageLabel.textColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
