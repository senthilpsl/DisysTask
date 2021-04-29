//
//  ViewController.swift
//  Test
//
//  Created by Mac Air on 26/04/21.
//  Copyright © 2021 Mac Air. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var nameTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var mobileTxt: UITextField!

    var viewModel: ProductViewModel = {
           return ProductViewModel()
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        
        nameTxt.delegate = self

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.nameTxt.frame.height))
        nameTxt.leftView = paddingView
        nameTxt.leftViewMode = UITextField.ViewMode.always
        
        emailTxt.delegate = self

        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.emailTxt.frame.height))
        emailTxt.leftView = paddingView1
        emailTxt.leftViewMode = UITextField.ViewMode.always

        
        mobileTxt.delegate = self

        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.nameTxt.frame.height))
        mobileTxt.leftView = paddingView2
        mobileTxt.leftViewMode = UITextField.ViewMode.always



        // Do any additional setup after loading the view.
    }
func ShowAlert (alertStr: String)
{
    var dialogMessage = UIAlertController(title: "Alert", message:alertStr, preferredStyle: .alert)

    // Create OK button with action handler
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
    })

 
    //Add OK and Cancel button to an Alert object
    dialogMessage.addAction(ok)

    // Present alert message to user
    self.present(dialogMessage, animated: true, completion: nil)
}
  @IBAction func SubmitBtn(sender: UIButton){
      
    var alertStr : String
    if self.nameTxt.text == "" {
        alertStr = "Please Enter Name"
        ShowAlert(alertStr: alertStr)
        return;
    }
    if emailTxt.text == "" {
         alertStr = "Please Enter email"
        ShowAlert(alertStr: alertStr)

           return;
       }
    if emailTxt.text?.isValidEmail != true
     {
        alertStr = "Please Enter Valid Email"
        ShowAlert(alertStr: alertStr)

      return;
     }
    if mobileTxt.text == "" {
          alertStr = "Please Enter mobile"
          ShowAlert(alertStr: alertStr)

           return;
       }
    
    
    
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text = "Loading"
  
    var arr:[String] = []

    arr.append(nameTxt.text ?? "")
    arr.append(self.emailTxt.text ?? "")
    arr.append(self.mobileTxt.text ?? "")

    viewModel.getData(parameterArr: arr) { (success, error) in
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.ShowAlert(alertStr: self.viewModel.productModels!)
            self.nameTxt.text = ""
             self.mobileTxt.text = ""
             self.emailTxt.text = ""

                              hud.hide(animated: true)
                          }
    }
    }
    
    
}
extension String {
   var isValidEmail: Bool {
      let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
      return testEmail.evaluate(with: self)
   }
   
}




