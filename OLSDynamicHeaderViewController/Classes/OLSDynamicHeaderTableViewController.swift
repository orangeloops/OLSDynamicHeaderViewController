//
//  OLSDynamicHeaderTableViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/24/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

open class OLSDynamicHeaderTableViewController: OLSDynamicHeaderViewController, UITableViewDelegate, UITableViewDataSource {

    // This helps for scenarios when the header needs to have user interaction
    class OLSDynamicHeaderTableView: UITableView {

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard point.y > 0 else {
                return nil
            }

            return super.hitTest(point, with: event)
        }
    }

    public var tableView: UITableView!

    open override func scrollViewInstance() -> UIScrollView {
        tableView = OLSDynamicHeaderTableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }

    // MARK: - Table view data source
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Override in subclasses")
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Override in subclasses")
    }
}
