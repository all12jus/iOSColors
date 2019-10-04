//
//  ConstraintUtils.swift
//
//  Created by Justin Allen on 8/15/19.
//  Copyright © 2019 Justin Allen. All rights reserved.
//

import UIKit

class Utils {
    public struct Contraints {
        var topAnchor : NSLayoutConstraint? = nil
        var leadingAnchor : NSLayoutConstraint? = nil
        var trailingAnchor : NSLayoutConstraint? = nil
        var bottomAnchor : NSLayoutConstraint? = nil
        var widthAnchor : NSLayoutConstraint? = nil
        var heightAnchor : NSLayoutConstraint? = nil
    }
    
    public static func SetupContrains(
        child : UIView, parent: UILayoutGuide,
        top: Bool = true, topConstant: CGFloat? = nil, topTarget: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
        leading:Bool = true, leadingConstant: CGFloat? = nil, leadingTarget: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
        trailing:Bool = true, trailingConstant: CGFloat? = nil, trailingTarget: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
        bottom:Bool = true, bottomConstant: CGFloat? = nil, bottomTarget: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
        width: Bool = false, widthConstant: CGFloat? = nil,
        height: Bool = false, heightConstant: CGFloat? = nil
    ) -> Contraints {
        child.translatesAutoresizingMaskIntoConstraints = false
        var constraints : Contraints = Contraints()
        
        if top {
            let target = topTarget ?? parent.topAnchor
            if let constant = topConstant {
                constraints.topAnchor = child.topAnchor.constraint(equalTo: target, constant: constant)
            } else {
                constraints.topAnchor = child.topAnchor.constraint(equalTo: target)
            }
            constraints.topAnchor?.isActive = true
        }
        
        if leading {
            let target = leadingTarget ?? parent.leadingAnchor
            if let constant = leadingConstant {
                constraints.leadingAnchor = child.leadingAnchor.constraint(equalTo: target, constant: constant)
            } else {
                constraints.leadingAnchor = child.leadingAnchor.constraint(equalTo: target)
            }
            constraints.leadingAnchor?.isActive = true
        }
        
        if trailing {
            let target = trailingTarget ?? parent.trailingAnchor
            if let constant = trailingConstant {
                constraints.trailingAnchor = child.trailingAnchor.constraint(equalTo: target, constant: constant)
            } else {
                constraints.trailingAnchor = child.trailingAnchor.constraint(equalTo: target)
            }
            constraints.trailingAnchor?.isActive = true
        }
        
        if bottom {
            let target = bottomTarget ?? parent.bottomAnchor
            if let constant = bottomConstant {
                constraints.bottomAnchor = child.bottomAnchor.constraint(equalTo: target, constant: constant)
            } else {
                constraints.bottomAnchor = child.bottomAnchor.constraint(equalTo: target)
            }
            constraints.bottomAnchor?.isActive = true
        }
        
        if width {
            if let constant = widthConstant {
                constraints.widthAnchor = child.widthAnchor.constraint(equalToConstant: constant)
            } else {
                // TODO: What do you do if it gets here?!
                print("widthConstant isn't set while width is enabled")
            }
            constraints.widthAnchor?.isActive = true
        }
        
        if height {
            if let constant = heightConstant {
                constraints.heightAnchor = child.heightAnchor.constraint(equalToConstant: constant)
            } else {
                // TODO: What do you do if it gets here?!
                print("heightConstant isn't set while height is enabled")
            }
            constraints.heightAnchor?.isActive = true
        }
        
        return constraints
    }
}
