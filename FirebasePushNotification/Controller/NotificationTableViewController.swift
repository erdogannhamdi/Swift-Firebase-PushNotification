//
//  NotificationTableViewController.swift
//  FirebasePushNotification
//
//  Created by Apple on 30.06.2020.
//  Copyright © 2020 erdogan. All rights reserved.
//

import UIKit

class NotificationTableViewController: UITableViewController {

    var tableArray = [NotificationData]()
    var counter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc: NotificationCenter = NotificationCenter.default
        nc.addObserver(self, selector: #selector(self.onReceiveData(notification:)), name: .notificationTable, object: nil)
        
        self.tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell

        let indis = indexPath.row
        
        cell.lblServis.text = tableArray[indis].servisSaat
        cell.lblTelefon.text = tableArray[indis].telefonSaat
        cell.lblFark.text = tableArray[indis].saatFarki
        cell.lblSayac.text = tableArray[indis].sayac
        // Configure the cell...

        return cell
    }
    
    @objc func onReceiveData(notification: Notification){
        //print("Bilgi : \(notification.object)")
        if let bilgi = notification.object{
            print("onReceive func : \(bilgi)")
            //print("onReceiveData \(title)")
            let title = notification.userInfo!["title"] as? String
            let formatterLast = DateFormatter()
            formatterLast.dateFormat = "HH:mm:ss"
            let coreDate = formatterLast.date(from: title!)
            
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let d = formatter.string(from: currentDateTime)
            let phoneDate = formatter.date(from: d)
            
            let diffComponents = Calendar.current.dateComponents([.second], from: coreDate!, to: phoneDate!)
            let seconds = diffComponents.second
            
            let tabelData = NotificationData()
            tabelData.servisSaat = title!
            tabelData.telefonSaat = d
            tabelData.saatFarki = String(seconds!)
            
            counter = counter + 1
            tabelData.sayac = String(counter)
            tableArray.append(tabelData)
            self.tableView.reloadData()
            
        }
    }
    
}
