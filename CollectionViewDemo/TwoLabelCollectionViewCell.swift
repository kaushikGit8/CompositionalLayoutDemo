//
//  TwoLabelCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Kaushik on 25/02/23.
//

import UIKit

class TwoLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label1: UILabel! {
        didSet {
            label1.text = "sfsljkfbskjfbskjfbsdkhjbfksdbfks vsdhbfskjhfbskjhvfkhsbfk"
        }
    }
    
    @IBOutlet weak var label2: UILabel! {
        didSet {
            label1.font = .preferredFont(forTextStyle: .largeTitle)
            label2.font = .preferredFont(forTextStyle: .title3)
            label2.text = "hjsfvjhsefbkhb vsdm sak fbksdjfbkas fkjasflahslf haskfkasfkjabskjfba kbfjahbfa fbakjb kab skabkf kjbdskjfbkasuhfauhf awfhalhi flaih hbfskjhfbskjhvfkhsbfk"
        }
    }
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, at idx: UInt32) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.brown.cgColor
        mask.path = path.cgPath
        //mask.isHidden = true
        layer.insertSublayer(mask, at: 0)
    }
}
