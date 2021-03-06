//
//  ViewController.swift
//  Turkcell_TodoList_Odev4_3
//
//  Created by Gulsah Altiparmak on 23.01.2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var txtProduct: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var pvImage: UIPickerView!
    let datePicker = UIDatePicker()
    var db = DB()
    var selected = 0
    let alert = SCLAlert()
    var dataSource: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db.fncConnection()
        pvImage.dataSource = self
        pvImage.delegate = self
        dataSource = db.categoryList()
        //categoryCreate()
        showDatePicker()
        
    }
    //kategori ekleme VC
/*func categoryCreate() {
       var arr = ["Meyve","Sebze","Kırmızı Et","Deniz Ürünleri","Süt Ürünleri","Kozmetik & Kişisel Bakım","Temizlik","İçecek","Diğer"]
        
        for item in 0...8 {
            db.categoryInsert(categoryName: arr[item], categoryImage: item)
        }
    }*/
    @IBAction func btnAdd(_ sender: UIButton) {
        let product = txtProduct.text!
        let amount = txtAmount.text!
        let date = txtDate.text!
       // let category = dataSource[selected]
        let flag = fncIsValid(product: product, amount: amount, date: date)
        guard !flag else {
            let row = db.todoInsert(product: product, amount: amount, date: date, categoryId: (selected+1))
            if row>0 {
                alert.alertSuccess(title: "Başarılı", message: "Kayıt başarılı bir şekilde tamamlandı.")
                
                txtProduct.text = ""
                txtAmount.text = ""
                txtDate.text = ""
                
                
            }else{
                //db bağlantısı ile sorun olursa kayıt yapılamazsa
                alert.alertError(title: "Hata", message: "Kayıt Yapılamadı")
            }
            return
        }
      
    }
    
    
    @IBAction func btnList(_ sender: UIButton) {
        
    }
    func fncIsValid(product:String, amount:String,date:String) -> (Bool) {
        guard product != "" , amount != "",date != "" else {
            alert.alertWarning(title: "Uyarı", message: "Lütfen yukarıdaki alanları boş bırakmayın.")
            
            return false
        }
        return true
    }
    
    func showDatePicker(){
      //Formate Date
     datePicker.datePickerMode = .date
     datePicker.preferredDatePickerStyle = .wheels
        

     //ToolBar
     let toolbar = UIToolbar();
     toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(cancelDatePicker));

   toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)

        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        

   }
    @objc func donedatePicker(){
    
     let formatter = DateFormatter()
     formatter.dateFormat = "dd/MM/yyyy"
     formatter.dateStyle = .medium
     formatter.timeStyle = .none
    txtDate.text = formatter.string(from: datePicker.date)
     self.view.endEditing(true)
        
      
   }

   @objc func cancelDatePicker(){
      self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selected = row
      
    }
    
}

