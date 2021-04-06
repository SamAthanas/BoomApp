//
//  TableViewController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet var historyTable: UITableView!
    var historyModel:HistoryModel = HistoryModel();
    var coreData:CoreDataModel = CoreDataModel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        historyTable.rowHeight = 75;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyModel.getHistoryCount();
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell

        let historyObject:HistoryInstance = historyModel.getHistoryAtIndex(index:indexPath.row);
        
        cell.cellTime.text = historyObject.getTime();
        cell.cellDate.text = historyObject.getDate();

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            let historyInstance:HistoryInstance = historyModel.getHistoryAtIndex(index: indexPath[1]);
            coreData.deleteTableEntry(time:historyInstance.getTime(),date: historyInstance.getDate() );
            
            historyModel.removeHistoryAtIndex(index: indexPath[1]);
            historyTable.reloadData();
            
            let a = UIAlertController(title:"History Deleted",message:"History has been deleted from coredata",preferredStyle:.alert);
            a.addAction(UIAlertAction(title:"Confirm",style:.cancel) );
            self.present(a,animated:true,completion:nil);
        } else if editingStyle == .insert {

        }
    }

    @IBAction func addHistory(_ sender: Any) {
        let alert = UIAlertController(title:"Add Missing History",message:"Type the missing information below",preferredStyle:.alert);
        
        let okButton = UIAlertAction(title:"Confirm",style:.default){
            (action) in
            
            let timeTextField = alert.textFields![0];
            let dateTextField = alert.textFields![1];
            
            var msg:String? = nil;
            
            if (timeTextField.text == "") {
                msg = "Cannot save empty history time!";
            }
            
            if (dateTextField.text == "") {
                msg = "Cannot save empty date for history!";
            }
            
            if (msg != nil) {
                let a = UIAlertController(title:"Save Failure",message:msg,preferredStyle:.alert);
                a.addAction(UIAlertAction(title:"OK",style:.cancel) );
                self.present(a,animated:true,completion:nil);
                
                return;
            }
            
            self.coreData.saveTableEntry(time: timeTextField.text!, date: dateTextField.text!);
            self.historyModel.addHistory(time: timeTextField.text!, date: dateTextField.text!);
            self.historyTable.reloadData();
            
            let a = UIAlertController(title:"Save Success",message:"Missing history saved and recoded to app coredata",preferredStyle:.alert);
            a.addAction(UIAlertAction(title:"OK",style:.cancel) );
            self.present(a,animated:true,completion:nil);
        }
        
        let cancelButton = UIAlertAction(title:"Cancel",style:.cancel);
        
        alert.addTextField { (textField) in
            textField.placeholder = "History Time";
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "History Date";
        }
        
        alert.addAction(okButton);
        alert.addAction(cancelButton);
        
        self.present(alert,animated:true,completion:nil);
    }
}
