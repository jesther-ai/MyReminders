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
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else{return}
        
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyReminder(title: title, date: date, identifier: "ID_\(title)")
                self.models.append(new)
                self.table.reloadData()
                self.schedule(title: title, body: body, date: date)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func didTapTest() {
        //fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                self.schedule()
            }
            else if  error != nil{
                print("Error Occured:\(error!)")
            }
        }
    }
    
    func schedule(){
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "Some Content", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil{
                print("GOOD TO GO")
            }
        }
    }
    /// actual schedule
    func schedule(title:String, body:String, date:Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        
        let targetDate = date
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "Some Content", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil{
                print("GOOD TO GO")
            }
        }
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
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
    }
}

struct MyReminder {
    let title:String
    let date:Date
    let identifier:String
}

