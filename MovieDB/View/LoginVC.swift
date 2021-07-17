//
//  ViewController.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

class LoginVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    enum Api:String {
        case query = "top_rated?"
        case baseUrl =  "https://api.themoviedb.org/3/movie/"
        case apikey = "api_key=a29fc5ebb2985a80efeb821d7b5e187e"
        case token = "d2f50d70c3e9b7c5a28d894f295b32e8d0e6598f"
    }
   
}

