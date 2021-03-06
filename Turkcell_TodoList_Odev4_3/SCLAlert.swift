//
//  SCLAlert.swift
//  Turkcell_TodoList_Odev4_3
//
//  Created by Gulsah Altiparmak on 23.01.2021.
//

import Foundation
import SCLAlertView

class SCLAlert {
  
    //var flag = false
    func alertInfo(title:String, message:String)  {
      let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "groceries") //Replace the IconImage text with the image name
        alertView.showInfo(title, subTitle:message, circleIconImage: alertViewIcon)
    }
    
    func alertWarning(title:String, message:String)  {
        SCLAlertView().showWarning(title, subTitle: message)
    }
  
    func alertSuccess(title:String,message:String)  {
        SCLAlertView().showTitle(
            title, // Title of view
            subTitle: message,
            timeout: nil,// String of view
            //duration: 2.0, // Duration to show before closing automatically, default: 0.0
            completeText: "Tamam", // Optional button value, default: ""
            style: .success, // Styles - see below.
            colorStyle: 0x1C9470,
            colorTextButton: 0xFFFFFF
        )
    }
    
    func alertError(title:String,message:String) {
        SCLAlertView().showError(title, subTitle:message)
    }
    
 
 /*  func alertNotify(title:String,message:String) -> Bool{
      
       let alertView = SCLAlertView()
        alertView.addButton("Evet"){
            self.flag = true
            print("birinci buton")
        }
        
        alertView.showSuccess(title, subTitle: message)
    
        return flag
 
    }
    
   @objc func firstButton()  {
    flag = true
    print("birinci button")
        
    }
    */
    
}

