//
//  LoadingCell.swift
//  Boilerplate-Mvvm
//
//  Created by Ario Bagus on 16/05/22.
//

import UIKit

class LoadingCell: UICollectionViewCell {

    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actIndicator.color = .white
    }
    
    func configureCell(width: CGFloat = 100) {
        self.width.constant = width
    }
}
