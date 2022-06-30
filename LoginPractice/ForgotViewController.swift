//
//  ForgotViewController.swift
//  LoginPractice
//
//  Created by LuongTran on 30/06/2022.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    let email = "nta4420@gmail.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError.isHidden = true
        customNavBar()
        customOutlet()
        
    }

    func customNavBar(){
        title = "Forgot Password"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(backLoginView));
        navigationController?.addCustomBottomLine(color: UIColor.tintColor, height: 2)
    }
    
    func customOutlet(){
        //border Textfield
        tfEmail.layer.borderWidth = 1.0
        tfEmail.layer.borderColor = UIColor.tintColor.cgColor
    }
    
    func checkForgot(){
        if(tfEmail.text!.isEmpty){
            lblError.isHidden = false
            lblError.text = "Email is empty!"
            let deadlineTime = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.lblError.isHidden = true
            }
        }else if(tfEmail.text?.isValidEmail() == false){
            lblError.isHidden = false
            lblError.text = "Invalid email!"
            let deadlineTime = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.lblError.isHidden = true
            }
        }else if(tfEmail.text?.isValidEmail() == true){
            let alert = UIAlertController(title: "Alert", message: "Success", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                switch action.style{
                    case .default:
                    let loginViewController = LoginViewController()
                    self.navigationController?.pushViewController(loginViewController, animated: true)
                    
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func backLoginView(){
        checkForgot()
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}


extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}
