//
//  OLSDynamicHeaderTableViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/24/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

class OLSDynamicHeaderTableViewController: OLSDynamicHeaderViewController, UITableViewDelegate, UITableViewDataSource {

    class OLSDynamicHeaderTableView: UITableView {

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard point.y > 0 else {
                return nil
            }

            return super.hitTest(point, with: event)
        }
    }

    var tableView: UITableView!

    override func scrollViewInstance() -> UIScrollView {
        tableView = OLSDynamicHeaderTableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Override in subclasses")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Override in subclasses")
    }
}
