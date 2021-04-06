//
//  PromotionsViewController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class PromotionsViewController: UIViewController {
    @IBOutlet weak var promotionsBox: UITextView!
    var text = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        promotionsBox.text = "Fetching data from server";

        getJsonData();
    }

    func getJsonData() {
           let urlAsString = "http://74.105.50.164:3001?get-daily-promos=1";

       let url = URL(string: urlAsString)!
       let urlSession = URLSession.shared
       
       let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
           if (error != nil) {
               print(error!.localizedDescription)
           }
           var err: NSError?
           
            if (data == nil) {
                print("Error: server did not return any data.")
                return;
           }
        
           var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
           if (err != nil) {
               print("JSON Error \(err!.localizedDescription)")
           }
           
            print(jsonResult);
        
            if (jsonResult["promotoday"] != nil && jsonResult["promoweek"] != nil) {
                let dailyPromo = jsonResult["promotoday"]! as! String;
                let weeklyPromo = jsonResult["promoweek"]! as! String;
                let visitorText = jsonResult["visitor"] as! String;
                
                var resultText = "";
                resultText += visitorText + "\n\n";
                resultText += dailyPromo + "\n\n";
                resultText += weeklyPromo;
                
                self.text = resultText;
            }
        DispatchQueue.main.async
        {
            self.promotionsBox.text = self.text;
        }
        
       });
        jsonQuery.resume();
    }
}
