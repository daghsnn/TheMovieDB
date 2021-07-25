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
    var isFavorite : Bool = false {
        didSet{
            if isFavorite == true {
                favoriteBtn.image = UIImage(systemName: "heart.fill") }
            else{
                favoriteBtn.image = UIImage(systemName: "heart")
            }
        }
    }
    var isWhist : Bool = false {
        didSet{
            if isWhist == true {
                whistListbtn.image = UIImage(systemName: "list.bullet.rectangle") }
            else{
                whistListbtn.image = UIImage(systemName: "list.dash")
            }
        }
    }
    let service = Service()
    @IBOutlet weak var whistListbtn: UIBarButtonItem!
    
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    
    var detailedMovie : MovieCellViewModel! {
        didSet {
            self.navigationItem.title = detailedMovie.name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailsView.detailedMovie = detailedMovie

    }
    
    @IBAction func whislistClicked(_ sender: Any) {
        
        isWhist = !isWhist
        service.postWatch(mediaId: detailedMovie.id, watch: isWhist)
        
    }
    @IBAction func favoriteListClicked(_ sender: Any) {
        
        
        isFavorite = !isFavorite
        service.postFavorite(mediaId: detailedMovie.id, favorite: isFavorite)
        
        
    }
}
