//
//  OLSDynamicHeaderViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/26/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

public protocol OLSDynamicHeaderViewControllerProtocol {
    func headerViewInstance() -> OLSDynamicHeaderView
    func scrollViewInstance() -> UIScrollView
}

open class OLSDynamicHeaderViewController: UIViewController, UIScrollViewDelegate, OLSDynamicHeaderViewControllerProtocol {

    fileprivate var scrollView: UIScrollView!
    fileprivate var headerView: OLSDynamicHeaderView!

    fileprivate var backgroundView: UIView!
    fileprivate var backgroundViewTopLayoutConstraint: NSLayoutConstraint!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setUpView()
    }

    override open func viewDidLayoutSubviews() {
        var scrollViewInset = scrollView.contentInset
        scrollViewInset.bottom = self.view.safeAreaInsets.bottom
        scrollView.contentInset = scrollViewInset
        scrollView.scrollIndicatorInsets = scrollViewInset
    }

    // MARK - OLSDynamicHeaderViewControllerProtocol
    open func headerViewInstance() -> OLSDynamicHeaderView {
        fatalError("Error: provide an instance of OLDynamicHeaderView")
    }

    open func scrollViewInstance() -> UIScrollView {
        fatalError("Error: provide an instance of UIScrollView class")
    }

    // MARK: - ScrollView view delegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        guard offset <= 0 else {
            backgroundViewTopLayoutConstraint.constant = headerView.minHeight()
            headerView.resize(withProgress: 0)
            return
        }

        let scrollProgress = abs(offset)
        let headerMax = headerViewMaxHeight()
        let headerMin = headerViewMinHeight()

        let totalDistance = headerMax - headerMin
        let backgroundConstant: CGFloat

        if scrollProgress <= totalDistance {
            let progress = scrollProgress/totalDistance

            let fixedProgress = progress < 0 ? 0 : min(progress, 1)
            headerView.resize(withProgress: fixedProgress)

            backgroundConstant = headerMin + scrollProgress

        } else {
            let offset = scrollProgress - totalDistance
            headerView.overflow(withPoints: offset)

            backgroundConstant = headerMax + offset
        }
        
        backgroundViewTopLayoutConstraint.constant = backgroundConstant
    }

    // MARK - Private
    fileprivate func setUpView() {
        view.backgroundColor = UIColor.white

        //Header view
        headerView = headerViewInstance()
        let headerMax = headerViewMaxHeight()
        let headerMin = headerViewMinHeight()
        let topOffset = headerMax - headerMin
        
        var headerViewFrame = view.bounds
        headerViewFrame.size.height = headerMax

        headerView.frame = headerViewFrame
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: headerMax).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        var backgroundViewFrame = view.bounds
        backgroundViewFrame.origin.y = headerMax
        backgroundViewFrame.size.height -= headerMax

        //Background view
        backgroundView = UIView(frame: backgroundViewFrame)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.white
        view.addSubview(backgroundView)
        
        backgroundViewTopLayoutConstraint = backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300)
        backgroundViewTopLayoutConstraint.isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //Scroll View
        var scrollViewFrame = view.bounds
        scrollViewFrame.size.height -= headerMin
        scrollViewFrame.origin.y = headerMin

        scrollView = scrollViewInstance()
        scrollView.alpha = 0.4
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self

        let scrollInsets = UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = scrollInsets
        scrollView.scrollIndicatorInsets = scrollInsets
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: headerMin).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    fileprivate func headerViewMaxHeight() -> CGFloat {
        return headerView.maxHeight()
    }
    
    fileprivate func headerViewMinHeight() -> CGFloat {
        return headerView.minHeight()
    }
}
