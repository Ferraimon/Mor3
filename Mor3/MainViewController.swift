//
//  MainViewController.swift
//  Mor3
//
//  Created by Ferran Rosales on 18/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit
import Parse


class MainViewController: UIViewController {

    @IBOutlet weak var salirBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //salirBarButton.addTarget(self, action: #selector(salirClicked(_ :)), for: .touchUpInside)
        //salirBarButton.action = Selector(tap(_:))
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        print(PFUser.current()?.username)
        if (PFUser.current() == nil) {
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(viewController, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func salirClicked(_ sender: UIBarButtonItem) {
        PFUser.logOut()
        print("Saliste")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func salirClicked() {
        PFUser.logOut()
        print("Saliste")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(viewController, animated: true, completion: nil)

        
        
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
