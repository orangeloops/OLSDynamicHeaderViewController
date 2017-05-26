//
//  OLSDynamicHeaderView.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/24/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

protocol OLSDynamicHeaderViewProtocol {
    static func viewInstance() -> Self

    func maxHeight() -> CGFloat
    func minHeight() -> CGFloat
    func resizeWithProgress(_ progress: CGFloat) //0..1: 0 min height reached, 1 max height reached
    func overflowWithPoints(_ points: CGFloat) // 0..N 0 max size and N the amount of points
}

class OLSDynamicHeaderView: UIView, OLSDynamicHeaderViewProtocol {

    class func viewInstance() -> Self {
        fatalError("Must be implemented on subclasses")
    }

    func maxHeight() -> CGFloat {
        fatalError("Must be implemented on subclasses")
    }

    func minHeight() -> CGFloat {
        fatalError("Must be implemented on subclasses")
    }

    func resizeWithProgress(_ progress: CGFloat) {
        /* Default Implementation */
    }

    func overflowWithPoints(_ points: CGFloat) {
        /* Default Implementation */
    }
}
