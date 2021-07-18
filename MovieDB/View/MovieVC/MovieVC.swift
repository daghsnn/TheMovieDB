//
//  MovieVC.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

class MovieVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //    weak var  movieModel : [MovieVM] = []{
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    //
    lazy var viewModel : MovieListViewModel = {
        return MovieListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fecthMovies()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(viewModel)
        tableView.dataSource = self
        tableView.delegate = self
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   

    // MARK: - Table view data source

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.nameLbl.text = viewModel.moviecellView[indexPath.row].name
        cell.dateLbl.text = String(viewModel.moviecellView[indexPath.row].date.prefix(4))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "detailsVC") as? DetailVC
        let detailRow = viewModel.getCellViewModel(at: indexPath)
        vc?.detailedMovie = detailRow
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
   

}
