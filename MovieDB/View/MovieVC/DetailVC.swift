//
//  DetailVC.swift
//  MovieDB
//
//  Created by Hasan Dag on 18.07.2021.
//

import UIKit
import Kingfisher
final class DetailVC: UIViewController {

    @IBOutlet var detailsView: DetailsView!
    var detailedMovie : MovieCellViewModel! {
        didSet {
            self.navigationItem.title = detailedMovie.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailsView.detailedMovie = detailedMovie

    }
    
//    func setupViews(){
//        detailsView.lblDate.text = detailedMovie.date
//        detailsView.lblDescript.text = detailedMovie.descript
//        detailsView.lblName.text = detailedMovie.name
//        detailsView.lblRate.text = String(detailedMovie.voteAvr)
//        detailsView.imageMovie.kf.setImage(with: URL(string: detailedMovie.posterURL))
//    }
 
}
