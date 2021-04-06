//
//  HistoryModel.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class HistoryModel {
    var data:[HistoryInstance];
    var coreData:CoreDataModel;
    
    init() {
        data = [HistoryInstance]();
        coreData = CoreDataModel();
        
        // Load in previous history
        var historyCell:[HistoryCell] = coreData.loadTableEntries();
        for var cell in historyCell {
            self.addHistory(time: cell.cellTime!, date:cell.cellDate!);
        }
        //addHistory(time:"testtime",date:"testdate");
    }
    
    func addHistory(time: String,date:String) {
        var historyInstance:HistoryInstance = HistoryInstance(time: time,date:date);
        
        data.append(historyInstance);
    }
    
    func removeHistoryAtIndex(index: Int) {
        data.remove(at: index);
    }
    
    func getHistoryCount() -> Int {
        return data.count;
    }
    
    func getHistory() -> [HistoryInstance] {
        return data;
    }
    
    func getHistoryAtIndex(index: Int) -> HistoryInstance {
        return data[index];
    }
}
