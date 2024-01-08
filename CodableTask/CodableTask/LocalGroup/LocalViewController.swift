//
//  LocalViewController.swift
//  CodableTask
//
//  Created by Денис on 29.12.2023.
//

import Foundation
import UIKit

class LocalViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var isEnableSwitch: UISwitch!
    
    let storage = UserDefaults.standard;
    
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
        
        if let data = storage.data(forKey: "user_settings") {
            
            let decode = try! JSONDecoder().decode(LocalUserSettings.self, from: data)
            nameTextField.text = decode.name;
            passwordTextField.text = decode.password;
            isEnableSwitch.isOn = decode.isEnabled;
            
        } else {
            nameTextField.text = "";
            passwordTextField.text = "";
            isEnableSwitch.isOn = false;
        }
    }
        
        @IBAction func saveSettings(){
            let currentSettings = LocalUserSettings(
                name: nameTextField.text ?? "",
                password: passwordTextField.text ?? "",
                isEnabled: isEnableSwitch.isOn
            )
            
           let encoded = try! JSONEncoder().encode(currentSettings)
            storage.setValue(encoded, forKey: "user_settings")
            
        }
}
