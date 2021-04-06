//
//  SettingsViewController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var userBox: UITextField!
    @IBOutlet weak var phoneBox: UITextField!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var reloadToggle: UISwitch!
    
    
    var mainController:ViewController? = nil;
    var userSettings:UserSettings? = nil;
    let coreData:CoreDataModel = CoreDataModel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.loadUserSettings();
    }
    
    func loadUserSettings() {
        userSettings = coreData.loadUserSettings();
        if (userSettings != nil) {
            userBox.text = userSettings!.name;
            phoneBox.text = userSettings!.phone;
            emailBox.text = userSettings!.email;
            reloadToggle.isOn = userSettings!.autoreload;
        }
    }

    @IBAction func applyAction(_ sender: Any) {
        let a = UIAlertController(title:"Settings Set Success",message:"Settings have been saved successfully",preferredStyle:.alert);
        a.addAction(UIAlertAction(title:"OK",style:.cancel) {
            (action) in
            if (self.mainController != nil) {
                self.coreData.saveSettings(name: self.userBox.text!, email: self.emailBox.text!, phone: self.phoneBox.text!, autoreload: self.reloadToggle.isOn);
            }
            _ = self.navigationController?.popViewController(animated: true);
        });
        self.present(a,animated:true,completion:nil);
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
}
