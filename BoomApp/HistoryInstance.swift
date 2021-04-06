//
//  HistoryInstance.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class HistoryInstance {
    var rideTime:String;
    var rideDate:String;
    
    init() {
        rideTime = "";
        rideDate = "";
    }
    
    init(time: String,date:String) {
        self.rideTime = time;
        self.rideDate = date;
    }
    
    func setTime(time: String) {
        self.rideTime = time;
    }
    
    func setDate(date: String) {
        self.rideDate = date;
    }
    
    func getTime() -> String {
        return self.rideTime;
    }
    
    func getDate() -> String {
        return self.rideDate;
    }
}
