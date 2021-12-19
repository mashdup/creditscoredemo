//
//  UIView+Constraints.swift
//  clearscoretest
//
//  Created by Dillon Hoa on 19/12/2021.
//

import UIKit

extension UIView {

    func pinToParentView(_ inset: UIEdgeInsets = .zero) {
        if let parent = superview {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor, constant: inset.top),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: inset.left),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -inset.right),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -inset.bottom)
            ])
        }
    }
    
    func pinToView(_ view: UIView, inset: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom)
        ])
    }
    
    func pinToParentCenter(_ offset: CGSize = .zero) {
        if let parent = superview {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.width),
                self.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.height)
            ])
        }
    }
    
    func pinTo(left: NSLayoutXAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, inset: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left, constant: inset.left).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: inset.top).isActive = true
        }
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right, constant: -inset.right).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -inset.bottom).isActive = true
        }
    }

}
