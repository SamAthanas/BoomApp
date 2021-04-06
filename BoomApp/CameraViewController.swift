//
//  CameraViewController.swift
//  BoomApp
//
//  Created by Samuel Athanasenas on 11/29/20.
//  Copyright © 2020 Samuel Athanasenas. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var imageTypeSelection: UISegmentedControl!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    let picker = UIImagePickerController();
    var mainController:ViewController? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self;
    }

    @IBAction func addPhoto(_ sender: Any) {
        let type:Int = imageTypeSelection.selectedSegmentIndex;
        
        if (type == 0) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                feedbackLabel.isHidden = false;
                feedbackLabel.text = "Error: No Camera";
            }
        }
        else if (type == 1) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil);
        }
    }

    @IBAction func confirmPicture(_ sender: Any) {
        let a = UIAlertController(title:"QR Code Scan Success",message:"Ride Will Now Start",preferredStyle:.alert);
        a.addAction(UIAlertAction(title:"OK",style:.cancel) {
            (action) in
            if (self.mainController != nil) {
                self.mainController!.showActiveRide();
            }
            _ = self.navigationController?.popViewController(animated: true);
        });
        self.present(a,animated:true,completion:nil);
        
    }
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
       // Local variable inserted by Swift 4.2 migrator.
       let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
               picker .dismiss(animated: true, completion: nil)
               qrImage.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
               
               feedbackLabel.isHidden = false;
               feedbackLabel.text = "Image Set Success";
           }
           
           
           func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
               dismiss(animated: true, completion: nil);
               
               feedbackLabel.isHidden = false;
               feedbackLabel.text = "Image Set Cancelled";
           }
           
           override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
           }

    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
