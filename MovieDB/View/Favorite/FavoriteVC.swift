//
//  FavoriteVC.swift
//  MovieDB
//
//  Created by Hasan Dag on 25.07.2021.
//

import UIKit
import Kingfisher

class FavoriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel : MovieListViewModel = {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return MovieListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fecthFavories()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! favoriteCell
        cell.favoriteName.text = viewModel.moviecellView[indexPath.row].name
        cell.favoriteImg.kf.setImage(with: URL(string: viewModel.moviecellView[indexPath.row].posterURL))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "detailsVC") as? DetailVC
        let detailRow = viewModel.getCellViewModel(at: indexPath)
        vc?.detailedMovie = detailRow
        
        vc?.isFavorite = true
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
  
    


}
