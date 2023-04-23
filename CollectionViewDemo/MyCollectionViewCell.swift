//
//  MyCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Kaushik on 20/11/22.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = text
        }
    }
 
    var text: String? {
        didSet {
            label.font = .preferredFont(forTextStyle: .largeTitle)
            label.text = text
        }
    }
}
