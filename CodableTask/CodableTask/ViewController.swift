//
//  ViewController.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import UIKit

class ViewController: UIViewController {

    private let network = UrlSessinNetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        network.getUsers{ result in
            switch result{
            case .failure(_):
                print("ERROR!")
            case .success(let users):
                print(users)
            }
            
            
        }
    }


}

