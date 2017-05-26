//
//  OLSDynamicHeaderCollectionViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/26/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

class OLSDynamicHeaderCollectionViewController: OLSDynamicHeaderViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // This helps for scenarios when the header needs to have user interaction
    class OLSDynamicHeaderCollectionView: UICollectionView {

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            guard point.y > 0 else {
                return nil
            }

            return super.hitTest(point, with: event)
        }
    }

    var collectionView: UICollectionView!

    override func scrollViewInstance() -> UIScrollView {
        collectionView = OLSDynamicHeaderCollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }

    // MARK: - Table view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Override in subclasses")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Override in subclasses")
    }
}
