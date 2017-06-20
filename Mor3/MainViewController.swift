//
//  MainViewController.swift
//  Mor3
//
//  Created by Ferran Rosales on 18/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit
import Parse




class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var salirBarButton: UIBarButtonItem!
    var user = PFUser.current()
    var users : [PFObject]? = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadUsers()
        
        self.refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        tableView.refreshControl = refreshControl
        
        // Do any additional setup after loading the view.
    }
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        if (PFUser.current() == nil) {
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(viewController, animated: true, completion: nil)
            
        }
        
        loadUsers()
        
        PFGeoPoint.geoPointForCurrentLocation { (point:  PFGeoPoint?, error: Error?) in
            if error == nil {
                PFUser.current()!.setValue(point, forKey:"PFGeopoint")
                PFUser.current()!.saveInBackground()
            } else {
                print(error!)
            }
        }
        
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUsers() {
        
        let query = PFUser.query()
        PFGeoPoint.geoPointForCurrentLocation { (point:  PFGeoPoint?, error: Error?) in
            if error == nil {
                query?.whereKey("PFGeopoint", nearGeoPoint: point!)
                query?.findObjectsInBackground { (usuarios: [PFObject]?, error: Error?) in
                    if let usuarios = usuarios as [PFObject]? {
                        self.users? = usuarios
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                        
                    } else {
                        print(error!)
                        print("algo ha salido mal")
                    }
                    
                }
            } else {
                print(error!)
            }
        }
    }
    
    @objc
    func doSomething(refreshControl: UIRefreshControl) {
        loadUsers()
        
    }
    @IBAction func salirClicked(_ sender: UIBarButtonItem) {
        PFUser.logOut()
        print("Saliste")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc
    
    func salirClicked() {
        PFUser.logOut()
        print("Saliste")
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(viewController, animated: true, completion: nil)

        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let losDatos = self.users![indexPath.row]
        
        cell.nombreLabel.text = losDatos["name"] as? String
        cell.edadLabel.text = losDatos["edad"] as? String
        cell.eresLabel.text = losDatos["eres"] as? String
        
        let userImageFile = losDatos["pofilePic"] as! PFFile
        userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.fotoImageView.image = image
                    cell.fotoImageView.layer.borderWidth = 4.0
                    cell.fotoImageView.layer.masksToBounds = false
                    cell.fotoImageView.layer.borderColor = UIColor.white.cgColor
                    cell.fotoImageView.layer.cornerRadius = cell.fotoImageView.frame.size.width/2
                    cell.fotoImageView.clipsToBounds = true
                    cell.backgroundImageView.addBlurEffect()
                    cell.backgroundImageView.image = image
                }
            }
        }
        
        
        
        
        
        return cell
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

extension UIImageView
{
    func addBlurEffect()
    {
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.85
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = self.bounds
        //self.addSubview(vibrancyEffectView)
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
        
        
    }
}
