//
//  ViewController.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

final class LoginVC: UIViewController {
    
    var User : UserData?
    @IBOutlet var loginView: LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRequestToken()

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func btnClicked(_ sender: Any) {
        
        if loginView.emailTxt.text != nil && loginView.passworTxt.text != nil {
            postRequest(username: loginView.emailTxt.text!, password: loginView.passworTxt.text!, token: REQUEST_TOKEN)
            
            User?.session_id = SESSION_ID
            User?.request_token = REQUEST_TOKEN
            performSegue(withIdentifier: "toMovieVC", sender: nil)
        }
        
        
    }
    @IBAction func otherBtnClicked(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieVC"{
        let destinationVC = segue.destination as! UINavigationController
            
        }
        
    }
private func createRequestToken(){
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
                let request = try! JSONDecoder().decode(sessionId.self, from: data!)
                REQUEST_TOKEN = request.request_token!
                self.User?.request_token = REQUEST_TOKEN
                print(REQUEST_TOKEN)
            }
            
        }.resume()
    
}
    
   
}
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
    
//    let sceneDelegete = UIApplication.shared.delegate as! SceneDelegate
//    sceneDelegete.user?.session_success = encoder!.session_success!

    
    print(SESSION_ID)
})

task.resume()
}
