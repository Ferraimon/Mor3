//
//  DetalleViewController.swift
//  Mor3
//
//  Created by Ferran Rosales on 24/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit
import Parse

class DetalleViewController: UIViewController {
    
    var datosRecibidos : PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(datosRecibidos)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
