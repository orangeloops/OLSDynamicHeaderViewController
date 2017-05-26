//
//  OLSDynamicHeaderViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/26/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

protocol OLSDynamicHeaderViewControllerProtocol {
    func headerViewInstance() -> OLSDynamicHeaderView
    func scrollViewInstance() -> UIScrollView
}

class OLSDynamicHeaderViewController: UIViewController, UIScrollViewDelegate, OLSDynamicHeaderViewControllerProtocol {

    fileprivate var scrollView: UIScrollView!
    fileprivate var headerView: OLSDynamicHeaderView!

    fileprivate var backgroundView: UIView!
    fileprivate var backgroundViewTopLayoutConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.clipsToBounds = true

        setUpView()
    }

    override func viewDidLayoutSubviews() {
        var scrollViewInset = scrollView.contentInset
        scrollViewInset.bottom = bottomLayoutGuide.length
        scrollView.contentInset = scrollViewInset
        scrollView.scrollIndicatorInsets = scrollViewInset
    }

    // MARK - OLSDynamicHeaderViewControllerProtocol
    func headerViewInstance() -> OLSDynamicHeaderView {
        fatalError("Error: provide an instance of OLDynamicHeaderView")
    }

    func scrollViewInstance() -> UIScrollView {
        fatalError("Error: provide an instance of UIScrollView class")
    }

    // MARK: - ScrollView view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        guard offset <= 0 else {
            backgroundViewTopLayoutConstraint.constant = headerView.minHeight()
            headerView.resizeWithProgress(0)
            return
        }

        let scrollProgress = fabs(offset)
        let headerMax = headerView.maxHeight()
        let headerMin = headerView.minHeight()

        let totalDistance = headerMax - headerMin
        let backgroundConstant: CGFloat

        if scrollProgress <= totalDistance {
            let progress = scrollProgress/totalDistance

            let fixedProgress = progress < 0 ? 0 : min(progress, 1)
            headerView.resizeWithProgress(fixedProgress)

            backgroundConstant = headerMin + scrollProgress


        } else {
            let offset = scrollProgress - totalDistance
            headerView.overflowWithPoints(offset)

            backgroundConstant = headerMax + offset
        }
        
        backgroundViewTopLayoutConstraint.constant = backgroundConstant
    }

    // MARK - Private
    fileprivate func setUpView() {
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false

        //Header view
        headerView = headerViewInstance()
        let headerMax = headerView.maxHeight()
        let headerMin = headerView.minHeight()
        let topOffset = headerMax - headerMin

        var headerViewFrame = view.bounds
        headerViewFrame.size.height = headerMax

        headerView.frame = headerViewFrame
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        var headerConstraints = [NSLayoutConstraint]()
        headerConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["headerView": headerView] as [String: UIView]))
        headerConstraints.append(NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        headerConstraints.append(NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerMax))
        NSLayoutConstraint.activate(headerConstraints)

        var backgroundViewFrame = view.bounds
        backgroundViewFrame.origin.y = headerMax
        backgroundViewFrame.size.height -= headerMax

        //Background view
        backgroundView = UIView(frame: backgroundViewFrame)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.white
        view.addSubview(backgroundView)

        backgroundViewTopLayoutConstraint = NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 300)

        var backgroundViewConstraints = [NSLayoutConstraint]()
        backgroundViewConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["backgroundView": backgroundView] as [String: UIView]))
        backgroundViewConstraints.append(NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        backgroundViewConstraints.append(backgroundViewTopLayoutConstraint)
        NSLayoutConstraint.activate(backgroundViewConstraints)

        //Scroll View
        var scrollViewFrame = view.bounds
        scrollViewFrame.size.height -= headerMin
        scrollViewFrame.origin.y = headerMin

        scrollView = scrollViewInstance()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self

        let scrollInsets = UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = scrollInsets
        scrollView.scrollIndicatorInsets = scrollInsets
        view.addSubview(scrollView)

        let viewBindings: [String: UIView] = ["scrollView": scrollView]
        var scrollViewConstraints = [NSLayoutConstraint]()
        scrollViewConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings))
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: headerMin))
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        NSLayoutConstraint.activate(scrollViewConstraints)
    }
}
