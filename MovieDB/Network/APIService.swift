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
enum Api:String {
    case search = "search/"
    case query = "top_rated?"
    case baseUrl =  "https://api.themoviedb.org/3/movie/"
    case apikey = "a29fc5ebb2985a80efeb821d7b5e187e"
    case token = "7f0357a9985452405265e42e45b3280b"
}


enum queries : String {
    case toprated =  "top_rated?"
    case search = "query="
    case getToken = "authentication/token/new?"
    case createSession = "/authentication/session/new?"
}




class Service : APIServiceProtocol {
    func fetchMovies(complete: @escaping ([Result]) -> ()) {
        let urlString = "\(Api.baseUrl)movie/top_rated?api_key=a29fc5ebb2985a80efeb821d7b5e187e&language=en-US&page=20"
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
