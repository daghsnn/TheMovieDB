//
//  LoginView.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

class LoginView: UIView {

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
        
//            if emailTxt.text!.isEmpty {
//                } else if passworTxt.text!.isEmpty {
//                } else {
                    createRequestToken()
    }
    
    @IBAction func loginSiteClicked(_ sender: Any) {
    }

        
//        func postRequest(username: String, password: String, completion: @escaping (UserData) -> Void) {
//
//
//            let parameters = ["name": username, "password": password]
//
//            let urlString = "\(Api.baseUrl)\(queries.getToken)?api_key=\(Api.apikey)"
//            guard let url = URL(string: urlString) else {
//                return
//            }
//
//            let session = URLSession.shared
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//
//            //HTTP Headers
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//            //create dataTask using the session object to send data to the server
//            let task = session.dataTask(with: request, completionHandler: { data, response, error in
//
//                guard error == nil else {
//                    completion(nil, error)
//                    return
//                }
//
//                guard let data = data else {
//                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
//                    return
//                }
//
//                do {
//                    //create json object from data
//                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
//                        completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
//                        return
//                    }
//                    print(json)
//                    completion(json, nil)
//                } catch let error {
//                    print(error.localizedDescription)
//                    completion(nil, error)
//                }
//            })
//
//            task.resume()
//        }
    func createRequestToken(){
        let urlString = "\(Api.baseUrl)\(queries.getToken)?api_key=\(Api.apikey)"
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
                    let request = try? JSONDecoder().decode(sessionId.self, from: data!)
                    REQUEST_TOKEN = request!.request_token
                    self.authSession?.request_token = REQUEST_TOKEN
                    print(REQUEST_TOKEN)
                    print(self.authSession?.request_token)
                }
                
            }.resume()
        
    }
    
}
