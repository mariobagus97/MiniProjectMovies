//
//  MovieCollCell.swift
//  MiniProject
//
//  Created by SehatQ on 21/08/22.
//

import UIKit

class MovieCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleased: UILabel!
    
    func configureCell(movie: Search?) {
        imgMovie.setImage(movie?.poster ?? "")
        lblTitle.text = movie?.title ?? "-"
        lblReleased.text = movie?.year ?? "-"
    }
}
