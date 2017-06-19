//
//  RegisterViewController.swift
//  Mor3
//
//  Created by Ferran Rosales on 16/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (eresTextField.isEditing) {
            return eresPicker.count
        }
        else if (buscasTextField.isEditing){
            return buscasPicker.count
        }
        else  if (rolTextField.isEditing){
            return rolPicker.count
        }
        else if (alturaTextField.isEditing) {
            return alturaPicker.count
        }
        else {
            return pesoPicker.count
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (eresTextField.isEditing) {
            return eresPicker[row]
            
        }
        else if (buscasTextField.isEditing){
            
            return buscasPicker[row]
            
        } else if (rolTextField.isEditing){
            
            return rolPicker[row]
            
        } else if (alturaTextField.isEditing) {
            return alturaPicker[row]
        } else {
            return pesoPicker[row]
        }
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (eresTextField.isEditing) {
            eresTextField.text = eresPicker[row]
            
        }
        else  if (buscasTextField.isEditing){
            
            buscasTextField.text = buscasPicker[row]
            
        } else if (rolTextField.isEditing){
            rolTextField.text = rolPicker[row]
        } else if (alturaTextField.isEditing) {
            alturaTextField.text = alturaPicker[row]
        } else {
            pesoTextField.text = pesoPicker[row]
        }
        self.view.endEditing(true)
        
    }
    
    
    @IBOutlet weak var buscasTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var edadTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var describeTextView: UITextView!
    @IBOutlet weak var pesoTextField: UITextField!
    @IBOutlet weak var alturaTextField: UITextField!
    @IBOutlet weak var rolTextField: UITextField!
    @IBOutlet weak var eresTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var eresPicker = ["Un chico Solo", "Una Pareja", "Un grupo de Amigos", "Un grupo Sexual"]
    var buscasPicker = ["Un chico Solo", "Una Pareja", "Un grupo de Amigos", "Un grupo Sexual", "Una Prueba"]
    var rolPicker = ["Activo", "Versatil", "Pasivo"]
    var alturaPicker = [String]()
    var pesoPicker = [String]()
    let imagePicker = UIImagePickerController()
    var profilePic : PFFile?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        self.userTextField.delegate = self
        self.describeTextView.delegate = self
        self.edadTextField.delegate = self
        self.emailTextField.delegate = self
        self.imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        //userTextField.placeholder = "Usuario"
        //edadTextField.placeholder = "Edad"
        //emailTextField.placeholder = "Email"
        //passwordTextField.placeholder = "Password"
        //userTextField.attributedPlaceholder = NSAttributedString(string: "Usuario", attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        for i in 150 ... 230 {
            alturaPicker.append(String(i))
        }
        
        for i in 50 ... 160 {
            pesoPicker.append(String(i))
        }
        eresTextField.inputView = pickerView
        buscasTextField.inputView = pickerView
        rolTextField.inputView = pickerView
        alturaTextField.inputView = pickerView
        pesoTextField.inputView = pickerView
        
        profileImageView.layer.borderWidth = 4.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelTouched(_ sender: UIButton) {
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profileImageView.image = chosenImage
        let imageData = UIImagePNGRepresentation(chosenImage)
        let imageFile = PFFile(name:"imagen.png", data:imageData!)
        profilePic = imageFile
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.describeTextView.text = ""
        self.view.frame.origin.y -= 165
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.frame.origin.y += 165
        return true
    }
    
    
    @IBAction func registroClicked(_ sender: UIButton) {
        PFUser.logOut()
        let user = PFUser()
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.username = emailTextField.text
        user["name"] = userTextField.text
        user["edad"] = edadTextField.text
        user["eres"] = eresTextField.text
        user["buscas"] = buscasTextField.text
        user["rol"] = rolTextField.text
        user["altura"] = alturaTextField.text
        user["peso"] = pesoTextField.text
        user["descripcion"] = describeTextView.text
        user["pofilePic"] = profilePic
        
        user.signUpInBackground { (succes: Bool, error: Error?) in
            if succes {
                print("Lo conseguiste!!")
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC")
                self.present(viewController, animated: true, completion: nil)
                
            } else {
                print("UH OH, algo has hecho mal")
            }
        }
        
        
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

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
