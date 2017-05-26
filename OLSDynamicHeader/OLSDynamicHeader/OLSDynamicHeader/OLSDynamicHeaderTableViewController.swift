//
//  OLSDynamicHeaderTableViewController.swift
//  OLSDynamicHeaderPOC
//
//  Created by Omar Hagopian on 5/24/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

protocol OLSDynamicHeaderViewControllerProtocol {
    func headerViewInstance() -> OLSDynamicHeaderView
}

class OLSDynamicHeaderTableViewController: UIViewController, OLSDynamicHeaderViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {

    class OLSDynamicHeaderTableView: UITableView {

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard point.y > 0 else {
                return nil
            }

            return super.hitTest(point, with: event)
        }
    }

    var tableView: UITableView!
    var headerView: OLSDynamicHeaderView!

    fileprivate var backgroundView: UIView!

    // MARK - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.view.clipsToBounds = true

        setUpView()
    }

    override func viewDidLayoutSubviews() {
        var tableInsets = tableView.contentInset
        tableInsets.bottom = bottomLayoutGuide.length
        self.tableView.contentInset = tableInsets
        self.tableView.scrollIndicatorInsets = tableInsets
    }

    // MARK - OLSDynamicHeaderViewControllerProtocol
    func headerViewInstance() -> OLSDynamicHeaderView {
        fatalError("Override in subclasses")
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Override in subclasses")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Override in subclasses")
    }

    // MARK: - ScrollView view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        guard offset <= 0 else {
            headerView.resizeWithProgress(0)
            self.view.layoutIfNeeded()
            return
        }

        let scrollProgress = fabs(offset)
        let headerMax = self.headerView.maxHeight()
        let headerMin = self.headerView.minHeight()

        let totalDistance = headerMax - headerMin

        if scrollProgress <= totalDistance {
            let progress = scrollProgress/totalDistance

            let fixedProgress = progress < 0 ? 0 : min(progress, 1)
            headerView.resizeWithProgress(fixedProgress)

        } else {
            let offset = scrollProgress - totalDistance
            headerView.overflowWithPoints(offset)
        }
    }

    // MARK - Private
    fileprivate func setUpView() {
        self.view.backgroundColor = UIColor.white
        self.view.translatesAutoresizingMaskIntoConstraints = false

        //Background view
        self.backgroundView = UIView(frame: self.view.bounds)
        self.backgroundView.isUserInteractionEnabled = false
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.backgroundColor = UIColor.white
        self.view.addSubview(self.backgroundView)

        var backgroundViewConstraints = [NSLayoutConstraint]()
        backgroundViewConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["backgroundView": self.backgroundView] as [String: UIView]))
        backgroundViewConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["backgroundView": self.backgroundView] as [String: UIView]))
        NSLayoutConstraint.activate(backgroundViewConstraints)

        //Header view
        self.headerView = self.headerViewInstance()
        let headerMax = self.headerView.maxHeight()
        let headerMin = self.headerView.minHeight()
        let topOffset = headerMax - headerMin

        var headerViewFrame = self.view.bounds
        headerViewFrame.size.height = headerMax

        self.headerView.frame = headerViewFrame
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.headerView)

        var headerConstraints = [NSLayoutConstraint]()
        headerConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["headerView": self.headerView] as [String: UIView]))
        headerConstraints.append(NSLayoutConstraint(item: self.headerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        headerConstraints.append(NSLayoutConstraint(item: self.headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerMax))
        NSLayoutConstraint.activate(headerConstraints)

        var backgroundViewFrame = self.view.bounds
        backgroundViewFrame.origin.y = headerMax
        backgroundViewFrame.size.height -= headerMax

        //Table view
        var tableViewFrame = self.view.bounds
        tableViewFrame.size.height -= headerMin
        tableViewFrame.origin.y = headerMin

        self.tableView = OLSDynamicHeaderTableView(frame: tableViewFrame, style: .plain)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let tableInsets = UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = tableInsets
        self.tableView.scrollIndicatorInsets = tableInsets
        self.view.addSubview(self.tableView)

        let viewBindings: [String: UIView] = ["tableView": self.tableView]
        var tableViewConstraints = [NSLayoutConstraint]()
        tableViewConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings))
        tableViewConstraints.append(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: headerMin))
        tableViewConstraints.append(NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}
