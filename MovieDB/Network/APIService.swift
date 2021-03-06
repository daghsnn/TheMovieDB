//
//  APIService.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import Foundation

protocol APIServiceProtocol {
    func fetchMovies( complete: @escaping ([Result])->() )
    func fetchFavorite( complete: @escaping ([Result])->() )
    func fetchWatch( complete: @escaping ([Result])->() )

    func createRequestToken()
    func searchMovies(name:String, complete: @escaping ([Result])->() )
    func postFavorite(mediaId : Int, favorite: Bool)
    func postWatch(mediaId : Int, watch: Bool)

}
enum Api:String {
    case search = "search/"
    case query = "top_rated?"
    case baseUrl =  "https://api.themoviedb.org/3/"
    case apikey = "api_key=a29fc5ebb2985a80efeb821d7b5e187e"
    case token = "7f0357a9985452405265e42e45b3280b"
}


enum queries : String {
    case account = "account?"
    case movie = "movie/"
    case toprated =  "top_rated?"
    case search = "search/"
    case getToken = "authentication/token/new?"
    case getSession = "authentication/session/new?"
    case createSession = "/authentication/token/validate_with_login?"
    case media_type = "media_type=movie"

}




class Service : APIServiceProtocol {
   
    
   
    
    func postWatch(mediaId: Int, watch: Bool) {
        let urlString = "\(Api.baseUrl.rawValue)account/\(ACCOUNT_ID)/watchlist?\(Api.apikey.rawValue)&session_id=\(SESSION_ID)&\(queries.media_type.rawValue)&media_id=\(mediaId)&watchlist=\(watch)"
        guard let url = URL(string: urlString) else {
            return
        }

        let config = URLSessionConfiguration.default

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        let session = URLSession(configuration: config)
        let task = URLSession.shared.dataTask(with: request) { (data, respone, error) in
            let responseString = String(data: data!, encoding: .utf8)
            
        }.resume()
    }
    
    func postFavorite(mediaId: Int, favorite: Bool) {
        let urlString = "\(Api.baseUrl.rawValue)account/\(ACCOUNT_ID)/favorite?\(Api.apikey.rawValue)&session_id=\(SESSION_ID)&\(queries.media_type.rawValue)&media_id=\(mediaId)&favorite=\(favorite)"
        guard let url = URL(string: urlString) else {
            return
        }

        let config = URLSessionConfiguration.default

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        let session = URLSession(configuration: config)
        let task = URLSession.shared.dataTask(with: request) { (data, respone, error) in
            let responseString = String(data: data!, encoding: .utf8)
            
        }.resume()
        
        
    }
    
   
    
    
    func createRequestToken() {
        let urlString = "\(Api.baseUrl.rawValue)\(queries.getToken.rawValue)\(Api.apikey.rawValue)"
        guard let url = URL(string: urlString) else {
            return
        }

        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data , response , error) in
                if error != nil {
                    print(error!)
                }
                else{
                    let request = try! JSONDecoder().decode(requestToken.self, from: data!)
                    REQUEST_TOKEN = request.request_token
                    print(REQUEST_TOKEN)
                }
                
            }.resume()
    }
    
    func fetchMovies(complete: @escaping ([Result]) -> ()) {
        let urlString = "\(Api.baseUrl.rawValue)\(queries.movie.rawValue)\(queries.toprated.rawValue)\(Api.apikey.rawValue)&language=en-US&page=20"
        print(urlString)
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
    func fetchFavorite(complete: @escaping ([Result]) -> ()) {
        let urlString = "\(Api.baseUrl.rawValue)account/\(ACCOUNT_ID)/favorite/movies?\(Api.apikey.rawValue)&session_id=\(SESSION_ID)&language=en-US&page=50"
        print(urlString)
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
                
                complete(results)
            }
            
        }.resume()
    }
    func fetchWatch(complete: @escaping ([Result]) -> ()) {
        let urlString = "\(Api.baseUrl.rawValue)account/\(ACCOUNT_ID)/watchlist/movies?\(Api.apikey.rawValue)&session_id=\(SESSION_ID)&language=en-US&page=50"
        print(urlString)
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
                
                complete(results)
            }
            
        }.resume()
    }
    func searchMovies(name: String,complete: @escaping ([Result]) -> ()) {
        let urlString = "\(Api.baseUrl.rawValue)\(queries.search.rawValue)movie?\(Api.apikey.rawValue)&language=en-US&query=\(name)&page=10"
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            else{
                print(urlString)
                do {
               
                    let movies = try JSONDecoder().decode(Movies.self, from: data!)
                    let results = movies.results
                    complete(results)

                } catch  {
                }
                //normal map
//                let movievm = results.map ({ return MovieVM(movies: $0)})
//                let moveicompat = results.compactMap({MovieVM(movies: $0)})
//                let modelresult = MovieVM(movies: results)
//                self.movieModel = results.map ({ return MovieVM(movies: $0)})
            }
            
        }.resume()
    }
    
    
}
