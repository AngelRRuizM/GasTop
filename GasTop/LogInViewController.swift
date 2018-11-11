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
        
        self.performSegue(withIdentifier: "toTabBar", sender: self)
        return;
        
        if (userMail.text?.isEmpty)! || (password.text?.isEmpty)! {
            let message = "Proporcione correo y contraseña validos"
            alertFailure(message)
        }
        else{
            let mail = userMail.text
            let pass = password.text
            
            var params = [String: String]()
            params["mail"] = mail
            params["password"] = pass
            
            HTTPHandler.makeHTTPPostRequest(route: "/login", parameters: params, callbackFunction: self.handleResponse)
            
        }
    }
    
    func handleResponse(data: Data?) -> Void {
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        if let array = json as? [Any]{
            if array.count == 1{
                let jsonDecoder = JSONDecoder()
                let array = try? jsonDecoder.decode([User].self, from: data!)
                
                let user = array!.first!
                //Hace set del email.
                User.loginLocalUser(id: user.id, username: user.username, email: user.email);
                //Como fue exitoso, pasa a la siguiente vista
                self.performSegue(withIdentifier: "toTabBar", sender: self)
            }
            else{
                //Si no fue exitoso, manda mensaje de error
                alertFailure("Usuario o contraseña incorrectos")
            }
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

