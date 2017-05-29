//
//  SampleHeaderView.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 9/7/16.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit
import OLSDynamicHeaderViewController

class SampleHeaderView: OLSDynamicHeaderView {

    let minHeaderHeight: CGFloat = 64 //navigation bar + status
    let maxHeaderHeight: CGFloat = 260

    let minLabelSpacing: CGFloat = 0
    let maxLabelSpacing: CGFloat = 0

    let minTitleFontSize: CGFloat = 18
    let maxTitleFontSize: CGFloat = 35

    let minBottomSpacing: CGFloat = 5
    let maxBottomSpacing: CGFloat = 16

    let minImageAlpha: CGFloat = 0
    let maxImageAlpha: CGFloat = 1.6

    let minBackgroundAlpha: CGFloat = 0.3
    let maxBackgroundAlpha: CGFloat = 2.0

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var bottomSpacingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelSpacingLayoutConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 12
    }

    class func viewInstance() -> SampleHeaderView {
        let defaultNib = UINib(nibName: "SampleHeaderView", bundle: nil)
        let view = defaultNib.instantiate(withOwner: nil, options: nil)[0] as? SampleHeaderView
        return view!
    }

    override func maxHeight() -> CGFloat {
        return maxHeaderHeight
    }

    override func minHeight() -> CGFloat {
        return minHeaderHeight
    }

    override func resize(withProgress progress: CGFloat) {
        //Some boring math =S
        let minHeight = self.minHeight()
        let maxHeight = self.maxHeight()
        let headerDistance = maxHeight - minHeight
        let progressConstantValue = headerDistance - (headerDistance * progress)

        let bottomValue = progressValue(minBottomSpacing, maxBottomSpacing, progress: progress)
        bottomSpacingLayoutConstraint.constant = progressConstantValue + bottomValue

        labelSpacingLayoutConstraint.constant = progressValue(minLabelSpacing, maxLabelSpacing, progress: progress)

        let fontFinalValue = progressValue(minTitleFontSize, maxTitleFontSize, progress: progress)
        titleLabel.font = UIFont(name: titleLabel.font!.familyName, size: fontFinalValue)

        profileImageView.alpha = progressValue(minImageAlpha, maxImageAlpha, progress: progress)
        backgroundImageView.alpha = progressValue(minBackgroundAlpha, maxBackgroundAlpha, progress: progress)
    }

    override func overflow(withPoints points: CGFloat) {
        //Reset everything
        bottomSpacingLayoutConstraint.constant = maxBottomSpacing - points
        labelSpacingLayoutConstraint.constant = maxLabelSpacing
        titleLabel.font = UIFont(name: titleLabel.font!.familyName, size: maxTitleFontSize)
        profileImageView.alpha = maxImageAlpha;
        backgroundImageView.alpha = maxBackgroundAlpha;

        //Fun image transformation =D
        var headerTransform = CATransform3DIdentity
        let headerScaleFactor:CGFloat = points / self.bounds.height
        let headerSizevariation = ((self.bounds.height * (1.0 + headerScaleFactor)) - self.bounds.height)/2.0
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)

        backgroundImageView.layer.transform = headerTransform
    }

    private func progressValue(_ min: CGFloat, _ max: CGFloat, progress: CGFloat) -> CGFloat { //Assuming progress 0..1
        let range = max - min
        let value = range * progress
        return min + value
    }
}
