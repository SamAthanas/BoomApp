//
//  CoreDataModel.swift
//  CSE355_Lab5_Samuel_Athanasenas
//
//  Created by Samuel Athanasenas on 10/14/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel {
    
    let insertContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
       
    var viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    init() {
        //saveTableEntry();
        //deleteTableEntry(index: 0);
        //print(loadTableEntries().count);
    }
    
    func saveSettings(name:String,email:String,phone:String,autoreload:Bool) {
        let ent = NSEntityDescription.entity(forEntityName: "UserSettings", in: self.insertContext!);
        let newItem = UserSettings(entity: ent!, insertInto: self.insertContext!);
        
        //newItem.cellTime = time;
        //newItem.cellDate = date;
        newItem.name = name;
        newItem.phone = phone;
        newItem.email = email;
        newItem.autoreload = autoreload;
        
         do {
            try self.insertContext?.save();
            print("Successfully saved new item");
         } catch _ {
            print("Error saving");
         }
    }
    
    func loadUserSettings() -> UserSettings? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSettings");
               
        if  let fetchResults = (try? viewContext.fetch(fetchRequest)) as? [UserSettings] {
           
            let x = fetchResults.count;

            if x != 0 {
                return fetchResults[x-1];
            }
            
        }
        
        return nil;
    }
    
    func saveTableEntry(time:String,date:String) {
        let ent = NSEntityDescription.entity(forEntityName: "HistoryCell", in: self.insertContext!);
        let newItem = HistoryCell(entity: ent!, insertInto: self.insertContext!);
        newItem.cellTime = time;
        newItem.cellDate = date;
        
         do {
            try self.insertContext?.save();
            print("Successfully saved new item");
         } catch _ {
            print("Error saving");
         }
    }
    
    func loadTableEntries() -> [HistoryCell] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryCell");
               
        if  let fetchResults = (try? viewContext.fetch(fetchRequest)) as? [HistoryCell] {
           
            let x = fetchResults.count;

            if x != 0 {
                return fetchResults;
            }
            
        }
        
        return [HistoryCell]();
    }
    
    func deleteTableEntry(index:Int) {
        let entries:[HistoryCell] = self.loadTableEntries();
        
        if index > entries.count {
            print("Error deleting: index higher then size");
            return;
        }
        
        insertContext?.delete(entries[index]);
        
        do {
            try self.insertContext?.save();
            print("Successfully deleted at index: " + String(index) );
        } catch _ {
           print("Error saving");
        }
    }
    
    func deleteTableEntry(time:String,date:String) {
        print("Processing delete request " + time);
        
        let entries:[HistoryCell] = self.loadTableEntries();

        for i in 0..<entries.count {
            //print(entries[i].title);
            if (entries[i].cellTime == time && entries[i].cellDate == date) {
                deleteTableEntry(index: i);
                return;
            }
        }
    }
}
