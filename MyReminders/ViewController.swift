//
//  ViewController.swift
//  MyReminders
//
//  Created by Jesther Silvestre on 5/18/21.
//
import UserNotifications
import UIKit

class ViewController: UIViewController{
    var models = [MyReminder]()
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func didTapAdd() {
        
    }
    @IBAction func didTapTest() {
        //fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                self.scheduleTest()
            }
            else if let error = error{
                print("Error Occured:\(error)")
            }
        }
    }
    
    func scheduleTest(){
        
    }
    

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        
        return cell
    }
}

struct MyReminder {
    let title:String
    let date:Date
    let identifier:String
}

