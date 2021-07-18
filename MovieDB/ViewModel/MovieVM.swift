//
//  MovieVM.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import Foundation



class MovieListViewModel {
    let apiService: APIServiceProtocol
    var movieList : [Result] = [Result]()
    var moviecellView : [MovieCellViewModel] = [MovieCellViewModel]()
    var numberOfCells: Int {
        return moviecellView.count
    }
    
    init( apiService: APIServiceProtocol = Service()) {
        self.apiService = apiService
    }
    func fecthMovies() {
        apiService.fetchMovies { (data) in
            self.fillModel(movies: data)
            print(self.moviecellView)
        }
    }
    func createCellViewModel( results: Result ) -> MovieCellViewModel {

        return MovieCellViewModel(name: results.originalTitle!, date: results.releaseDate!, posterURL: results.posterPath!, descript: results.overview!, adult: results.adult!, id: results.id!, voteAvr: results.voteAverage!, popularity: results.popularity!)
    }
    func getCellViewModel( at indexPath: IndexPath ) -> MovieCellViewModel {
        return moviecellView[indexPath.row]
    }
    func fillModel (movies : [Result] ){
        self.movieList = movies
        var vievmodelcell = [MovieCellViewModel]()
        for movie in movies {
            vievmodelcell.append(createCellViewModel(results: movie))
        }
        self.moviecellView = vievmodelcell
    }
}



//struct MovieListVM {
//    let movieList : [Result]
//    var MovieViewModel : Result
//    let date , name , imgURL : String
//    let id : Int
//    init(movies : Result) {
//        self.MovieViewModel = movies
//        self.date = movies.releaseDate ?? ""
//        self.name = movies.originalTitle ?? ""
//        self.id = movies.id ?? 0
//        self.imgURL = movies.posterPath ?? ""
//    }
//}


struct MovieCellViewModel {
    let name, date, posterURL, descript : String
    let adult : Bool
    let id : Int
    let voteAvr , popularity : Double
}
