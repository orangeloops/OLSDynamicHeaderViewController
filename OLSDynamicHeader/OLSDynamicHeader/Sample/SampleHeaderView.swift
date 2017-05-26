//
//  SampleHeaderView.swift
//  OLSDynamicHeader
//
//  Created by Omar Hagopian on 9/7/16.
//  Copyright © 2017 OrangeLoops. All rights reserved.
//

import UIKit

class SampleHeaderView: OLSDynamicHeaderView {

    let MIN_TEXT_SPACING: CGFloat = 0
    let MAX_TEXT_SPACING: CGFloat = 0

    let MIN_TITLE_FONT_SIZE: CGFloat = 18
    let MAX_TITLE_FONT_SIZE: CGFloat = 35

    let MIN_HEIGHT: CGFloat = 64 //navigation bar + status
    let MAX_HEIGHT: CGFloat = 260

    let MIN_BOTTOM_SPACING: CGFloat = 5
    let MAX_BOTTOM_SPACING: CGFloat = 16

    let MIN_IMAGE_ALPHA: CGFloat = 0
    let MAX_IMAGE_ALPHA: CGFloat = 1.6

    let MIN_BACKGROUND_ALPHA: CGFloat = 0.3
    let MAX_BACKGROUND_ALPHA: CGFloat = 2.0

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

    override class func viewInstance() -> SampleHeaderView {
        let defaultNib = UINib(nibName: "SampleHeaderView", bundle: nil)
        let view = defaultNib.instantiate(withOwner: nil, options: nil)[0] as? SampleHeaderView
        return view!
    }

    override func maxHeight() -> CGFloat {
        return MAX_HEIGHT
    }

    override func minHeight() -> CGFloat {
        return MIN_HEIGHT
    }

    override func resize(withProgress progress: CGFloat) {
        //Some boring math =S
        let minHeight = self.minHeight()
        let maxHeight = self.maxHeight()
        let headerDistance = maxHeight - minHeight
        let progressConstantValue = headerDistance - (headerDistance * progress)

        let bottomValue = progressValue(MIN_BOTTOM_SPACING, MAX_BOTTOM_SPACING, progress: progress)
        bottomSpacingLayoutConstraint.constant = progressConstantValue + bottomValue

        labelSpacingLayoutConstraint.constant = progressValue(MIN_TEXT_SPACING, MAX_TEXT_SPACING, progress: progress)

        let fontFinalValue = progressValue(MIN_TITLE_FONT_SIZE, MAX_TITLE_FONT_SIZE, progress: progress)
        titleLabel.font = UIFont(name: titleLabel.font!.familyName, size: fontFinalValue)

        profileImageView.alpha = progressValue(MIN_IMAGE_ALPHA, MAX_IMAGE_ALPHA, progress: progress)
        backgroundImageView.alpha = progressValue(MIN_BACKGROUND_ALPHA, MAX_BACKGROUND_ALPHA, progress: progress)
    }

    override func overflow(withPoints points: CGFloat) {
        //Reset everything
        bottomSpacingLayoutConstraint.constant = MAX_BOTTOM_SPACING - points
        labelSpacingLayoutConstraint.constant = MAX_TEXT_SPACING
        titleLabel.font = UIFont(name: titleLabel.font!.familyName, size: MAX_TITLE_FONT_SIZE)
        profileImageView.alpha = MAX_IMAGE_ALPHA;
        backgroundImageView.alpha = MAX_BACKGROUND_ALPHA;

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
