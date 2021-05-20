//
//  AddViewController.swift
//  MyReminders
//
//  Created by Jesther Silvestre on 5/18/21.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var titleField:UITextField!
    @IBOutlet var bodyField:UITextField!
    @IBOutlet var datePicker:UIDatePicker!
    
    public var completion:((String,String,Date)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func didTapSaveButton(){
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty{
            let targetDate = datePicker.date
        }
    }
    

}
