//
//  CollectionViewController.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 5/26/17.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit
import OLSDynamicHeaderViewController

class CollectionViewController: OLSDynamicHeaderCollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellIdenetifier = "defaultCellIdentifier"
    private var elements = [String]()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        for n in 1...100 {
            elements.append("Item \(n)")
        }

        super.viewDidLoad()

        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdenetifier)
    }

    override func headerViewInstance() -> OLSDynamicHeaderView {
        let view = SampleHeaderView.viewInstance()
        return view
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdenetifier, for: indexPath) as! CollectionViewCell
        cell.textLabel.text = elements[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4.0, height: 40)
    }
}
