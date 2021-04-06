//
//  ViewController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 10/28/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    var timer:Timer?
    var counter:Int = 0;
    @IBOutlet weak var activeRideTimer: UILabel!
    var rideActive = false;
    
    @IBOutlet weak var LeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var TrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var hamBackMenu: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var satelliteSwitch: UISwitch!
    @IBOutlet weak var activeRideView: UIView!
    @IBOutlet weak var rideButton: UIButton!
    
    var sideMenuOpen:Bool = false;
    let SIDE_MENU_EXPAND_AMT:CGFloat = 215;
    let coreData:CoreDataModel = CoreDataModel();
    
    var mapController:MapController? = nil;
    
    //var locations = ["test":[0,0]];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        mapController = MapController(map:self.mapView);
        mapController!.updateMap(latitude:33.4255,longitude:-111.9400);

        
        //print(locations["test"].0);
    }

    @IBAction func sideMenuButton(_ sender: Any) {
        sideMenuOpen = !sideMenuOpen;
        let constantValue:CGFloat = sideMenuOpen ? SIDE_MENU_EXPAND_AMT : 0;
        LeadingConstraint.constant = constantValue;
        TrailingConstraint.constant = -constantValue;
        
        UIView.animate(withDuration: 0.2,delay:0.0,options:.curveEaseIn,animations: { self.view.layoutIfNeeded();
        })
    }
    
    @IBAction func paymentTriggered(_ sender: Any) {
        let a = UIAlertController(title:"Demo Button",message:"This is just a demo button. Since the application isnt finished, I have no intention on storing credit card information at this stage",preferredStyle:.alert);
        a.addAction(UIAlertAction(title:"OK",style:.cancel));
        self.present(a,animated:true,completion:nil);
    }
    
    @IBAction func satelliteTriggered(_ sender: Any) {
        mapController?.setMapType(type: satelliteSwitch.isOn ? MKMapType.satellite : MKMapType.standard);
    }
    
    @IBAction func zoomInTriggered(_ sender: Any) {
        mapController?.mapZoom(true);
    }
    
    @IBAction func zoomOutTriggered(_ sender: Any) {
        mapController?.mapZoom(false);
    }
    
    @IBAction func endRideTriggered(_ sender: Any) {
        activeRideView.alpha = 0;
        
        let a = UIAlertController(title:"Ride Finished",message:"You rode for " + String(counter) + " seconds!",preferredStyle:.alert);
        a.addAction(UIAlertAction(title:"OK",style:.cancel));
        self.present(a,animated:true,completion:nil);
        
        rideButton.isEnabled = true;
        rideButton.alpha = 1;
        
        // Save the ride in history
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short);
        
        coreData.saveTableEntry(time: "Ride Time: " + String(counter) + " seconds", date: timestamp);
        
        stopTimer();
        rideActive = false;
    }
    
    func showActiveRide() {
        self.counter = 0;
        self.activeRideView.alpha = 1;
        self.activeRideView.isHidden = false;
        self.startTimer();
        self.rideActive = true;
        
        rideButton.isEnabled = false;
        rideButton.alpha = 0.5;
    }
    
    func startTimer() {
       timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.count), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        self.timer?.invalidate();
        self.counter = 0;
    }
    
    @objc func count() {
        counter = counter + 1;
        let hours = Int(counter) / 3600;
        let minutes = Int(counter) / 60 % 60;
        let seconds = Int(counter) % 60;
        activeRideTimer.text  = String(format:"%02i:%02i:%02i", hours, minutes, seconds);
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?) {
        if (segue.identifier == "toCamera") {
            let des = segue.destination as! CameraViewController
            des.mainController = self;
        }
        else if (segue.identifier == "toSettings") {
            let des = segue.destination as! SettingsViewController
            des.mainController = self;
        }
    }
}
