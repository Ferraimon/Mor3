//
//  LoginViewController.swift
//  Mor3
//
//  Created by Ferran Rosales on 16/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func returnRegistry(segue:UIStoryboardSegue!) {
        
    }
    
    
    @IBAction func entrarClicked(_ sender: UIButton) {
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if error == nil {
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC")
                self.present(viewController, animated: true, completion: nil)
            } else {
                print("La has cagado, repásalo")
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
