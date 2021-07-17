//
//  APIService.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import Foundation

protocol APIServiceProtocol {
    func fetchMovies( complete: @escaping ([Result])->() )
}

class Service : APIServiceProtocol {
    func fetchMovies(complete: @escaping ([Result]) -> ()) {
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
                complete(results)
            }
            
        }.resume()
    }
    
    
}
