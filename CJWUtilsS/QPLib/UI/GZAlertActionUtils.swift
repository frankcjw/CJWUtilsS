//
//  GZAlertActionUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

class GZAlertActionUtils: NSObject {

}

extension UIViewController {
    typealias GZAlertActionControllerInputBlock  = (text:String) -> ()
    
    func showInputAlert(title:String, message:String, inputtedText:String, keyboardType : UIKeyboardType, placeholder:String,block:GZAlertActionControllerInputBlock){
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
            let tf = actionSheet.textFields?.first
            tf?.resignFirstResponder()
            tf?.keyboardType = keyboardType
            if let text = tf?.text {
                if text != "" {
                    block(text: text)
                }
            }
        }
        
        actionSheet.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = placeholder
            if inputtedText != "" {
                textField.text = inputtedText
            }
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(comfirmAction)
        self.presentViewController(actionSheet, animated: true) { () -> Void in
        }
        
    }
    
    func showInputAlert(title:String, message:String, inputtedText:String, placeholder:String,block:GZAlertActionControllerInputBlock){
        showInputAlert(title, message: message, inputtedText: inputtedText, keyboardType: UIKeyboardType.Default, placeholder: placeholder, block: block)
    }
    
    func showConfirmAlert(title:String, message:String,confirm:CJWNormalBlock){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
            confirm()
        }
        actionSheet.addAction(comfirmAction)
        self.presentViewController(actionSheet, animated: true) { () -> Void in
        }
    }
    
    
    func showConfirmAlert(title:String, message:String,confirm:CJWNormalBlock , cancel:CJWNormalBlock){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            cancel()
        }
        let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
            confirm()
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(comfirmAction)
        self.presentViewController(actionSheet, animated: true) { () -> Void in
        }
    }
    
    typealias GZActionSheetBlock = (index:Int) -> ()
    func showActionSheet(title:String, message:String,buttons: Array<String> ,block:GZActionSheetBlock){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        for button in buttons {
            let index = buttons.indexOf(button)!
            let action = UIAlertAction(title: button, style: UIAlertActionStyle.Default) { (action) -> Void in
                block(index: index)
            }
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
        }
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true) { () -> Void in
        }
    }
}
