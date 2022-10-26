//
//  DeclerativeExtensions.swift
//  Bloc
//
//  Created by iMac on 10/25/22.
//

import Foundation
import UIKit

protocol Withable {
    
    associatedtype T
    
    @discardableResult func with(_ closure: (_ instance: T) -> Void) -> T
}
extension Withable {
    
    @discardableResult func with(_ closure: (_ instance: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
extension NSObject: Withable { }

extension Array where Element: UIView {
    
    func add(to stackView: UIStackView) {
        forEach { stackView.addArrangedSubview($0) }
    }
}

extension UIStackView {
    
    func horizontal(spacing: CGFloat = 0) -> Self {
        with {
            $0.axis = .horizontal
            $0.spacing = spacing
        }
    }
    
    func vertical(spacing: CGFloat = 0) -> Self {
        with {
            $0.axis = .vertical
            $0.spacing = spacing
        }
    }
    
    func views(_ views: UIView ...) -> Self {
        views.forEach { self.addArrangedSubview($0) }
        return self
    }
}

extension UIView {
    func removeAllSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    static var spacer: UIView {
        UIView().with {
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentHuggingPriority(.required, for: .vertical)
        }
    }
    
    func pin(to: UILayoutGuide, insets: UIEdgeInsets)  {
        guard let _ = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: to.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -insets.bottom).isActive = true
        leftAnchor.constraint(equalTo: to.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: to.rightAnchor, constant: -insets.right).isActive = true
    }
    
    func pin(to: UIView, insets: UIEdgeInsets)  {
        guard let _ = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: to.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -insets.bottom).isActive = true
        leftAnchor.constraint(equalTo: to.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: to.rightAnchor, constant: -insets.right).isActive = true
    }
}

