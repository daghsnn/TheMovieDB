//
//  ViewController.swift
//  MovieDB
//
//  Created by Hasan Dag on 17.07.2021.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet var loginView: LoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
   
   
}
