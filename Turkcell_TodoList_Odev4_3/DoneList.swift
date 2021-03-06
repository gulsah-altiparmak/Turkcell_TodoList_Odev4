//
//  DoneList.swift
//  Turkcell_TodoList_Odev4_3
//
//  Created by Gulsah Altiparmak on 25.01.2021.
//

import UIKit
import SCLAlertView

class DoneList: UITableViewController {

    let db = DB()
    let alert = SCLAlert()
    var arr:[Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.fncConnection()
        arr = db.todoList(isdone: true)

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
        return arr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell

        // Configure the cell...

        let item = arr[indexPath.row]
        cell.doneAmount.text = item.amount
        cell.doneTitle.text = item.product
        cell.doneImg.image =  UIImage(named:"\(item.categoryId-1)")
        cell.doneDate.text = item.date
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let item = arr[indexPath.row]
          //   alert.alertNotify(title: "Uyarı",message: "Seçilen öğeyi silmek istediğinizden emin misiniz?")
           
            let alertView = SCLAlertView()
            
            alertView.addButton("Evet") {
                let deleteRow = self.db.todoDelete(todoId: item.id)
                if deleteRow>0{
                    self.arr.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
            }
            }
            alertView.showSuccess("Uyarı", subTitle: "Seçilen öğeyi silmek istiyor musunuz?")
        }  
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arr[indexPath.row]
        alert.alertInfo(title: "\(item.product) : \(item.amount)", message: item.date)
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
