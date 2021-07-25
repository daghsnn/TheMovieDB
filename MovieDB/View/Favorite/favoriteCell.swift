//
//  favoriteCell.swift
//  MovieDB
//
//  Created by Hasan Dag on 25.07.2021.
//

import UIKit
import Kingfisher
class favoriteCell: UITableViewCell {

    @IBOutlet weak var favoriteName: UILabel!
    @IBOutlet weak var favoriteImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
