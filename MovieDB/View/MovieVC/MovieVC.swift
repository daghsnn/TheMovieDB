//
//  MovieVC.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

final class MovieVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var loginedUser : accountModel?
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
        searchBar.delegate = self
        viewModel.fecthMovies()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        

        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "detailsVC") as? DetailVC
        let detailRow = viewModel.getCellViewModel(at: indexPath)
        vc?.detailedMovie = detailRow
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let string = searchBar.text {
            if string.isEmpty {
                viewModel.fecthMovies()

            }
            else {
                viewModel.searchMovies(name: searchBar.text!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
           
        }
    }
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fecthMovies()
        dismiss(animated: true, completion: nil)
    }

   

}
