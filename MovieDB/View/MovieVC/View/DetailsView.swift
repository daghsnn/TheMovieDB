//
//  DetailsView.swift
//  MovieDB
//
//  Created by Hasan Dag on 18.07.2021.
//

import UIKit
import Kingfisher

final class DetailsView: UIView {

    var detailedMovie : MovieCellViewModel?

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescript: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    override func draw(_ rect: CGRect) {
        
        setupViews(detailedMovie: detailedMovie!)
    }

    func setupViews(detailedMovie : MovieCellViewModel ){
        lblDate.text = detailedMovie.date
        lblDescript.text = detailedMovie.descript
        lblName.text = detailedMovie.name
        lblRate.text = String(detailedMovie.voteAvr)
        imageMovie.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(detailedMovie.posterURL)"))
    }
}
