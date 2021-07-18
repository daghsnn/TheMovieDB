//
//  LoginView.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

final class LoginView: UIView {

    var authSession : sessionId?
    @IBOutlet weak var otherBtn: UIButton!
    @IBOutlet weak var passworTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func draw(_ rect: CGRect) {
        loginBtn.layer.cornerRadius = 10
        otherBtn.layer.cornerRadius = 10
    }
   
    @IBAction func loginClicked(_ sender: Any) {
        
        
        
    }
    
    @IBAction func loginSiteClicked(_ sender: Any) {
    }
//    , completion: @escaping (UserData) -> Void
        
    
    

}

// MARK: Functions
private func postRequest(username: String, password: String, token : String) {

        let urlString = "\(Api.baseUrl.rawValue)\(queries.createSession.rawValue)\(Api.apikey.rawValue)&username=\(username)&password=\(password)&request_token=\(token)"
        guard let url = URL(string: urlString) else {
            return
        }

        let config = URLSessionConfiguration.default

        var request = URLRequest(url: url)

        request.httpMethod = "POST"


        
        let session = URLSession(configuration: config)


    let task = session.dataTask(with: url as URL, completionHandler: {(data, response, error) in
        createSession(token: token)
    }).resume()
    }
private func createSession(token:String) {
    
    let urlString = "\(Api.baseUrl.rawValue)\(queries.getSession.rawValue)\(Api.apikey.rawValue)&request_token=\(token)"
    guard let url = URL(string: urlString) else {
        return
    }

    let config = URLSessionConfiguration.default

    var request = URLRequest(url: url)

    request.httpMethod = "POST"


    
    let session = URLSession(configuration: config)


let task = session.dataTask(with: url as URL, completionHandler: {(data, response, error) in
    print(response)
    print(data)
    let encoder = try? JSONDecoder().decode(sessionId.self, from: data!)
    SESSION_ID = encoder!.session_id!
    print(SESSION_ID)
})

task.resume()
}
