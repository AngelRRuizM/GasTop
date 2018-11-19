//
//  ViewController.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userMail: UITextField!
    
    @IBOutlet weak var password: UITextField!
        
    @IBAction func login(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userMail.delegate = self
        password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func logIn(_ sender: Any) {
        
        if (userMail.text?.isEmpty)! || (password.text?.isEmpty)! {
            let message = "Proporcione correo y contraseña validos"
            alertFailure(message)
        }
        else{
            let email = userMail.text
            let pass = password.text
            
            User.login(email: email!, password: pass!, callback: wasLoginSuccesful);
           
        }
    }
    
    func wasLoginSuccesful(_ user: User?) {
        if (user != nil) {
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        }
        else {
            alertFailure("Usuario o contraseña incorrectos");
        }
    }
    
    func alertFailure(_ message: String){
        let alert = UIAlertController(title: "Atención", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {
            (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(ok)
        present(alert, animated:  true, completion: nil)
    }
    
}

