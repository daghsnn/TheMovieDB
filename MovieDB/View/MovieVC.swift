//
//  MovieVC.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

class MovieVC: UITableViewController {
    
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
        print(viewModel)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfCells

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell

//        let cellIndex = viewModel.getCellViewModel(at: indexPath)

        // Configure the cell...
        cell!.labell.text = viewModel.moviecellView[indexPath.row].name
        return cell!
    }
   
    
    func getMovies()
    {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=a29fc5ebb2985a80efeb821d7b5e187e&language=en-US&page=20"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            else{
                let movies = try! JSONDecoder().decode(Movies.self, from: data!)
                let results = movies.results
//                let movievm = results.map ({ return MovieVM(movies: $0)})
//                let modelresult = MovieVM(movies: results)
//                self.movieModel = results.map ({ return MovieVM(movies: $0)})
                
            }
            
        }.resume()
    }
    func getMoviescomp(comp : @escaping([Result]) -> Void)
    {
        let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=a29fc5ebb2985a80efeb821d7b5e187e&language=en-US&page=20"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            else{
                let movies = try! JSONDecoder().decode(Movies.self, from: data!)
                let results = movies.results
                //normal map
//                let movievm = results.map ({ return MovieVM(movies: $0)})
//                let moveicompat = results.compactMap({MovieVM(movies: $0)})
//                let modelresult = MovieVM(movies: results)
//                self.movieModel = results.map ({ return MovieVM(movies: $0)})
                comp(results)
            }
            
        }.resume()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
