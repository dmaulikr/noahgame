//
//  LoginController.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImageView)))
        profileImageView.isUserInteractionEnabled = true
    }

    @IBAction func signIn(_ sender: Any) {
        guard let email = emailTextField.text,
            let pass = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        NoahService.shared.signIn(email, password: pass, completion: { user in
            UserDefaults.standard.set(user.name, forKey: "user_name")
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let pass = passwordTextField.text,
            let profileImage = profileImageView.image else {
            print("Form is not valid")
            return
        }
            
        NoahService.shared.signUp(name, email: email, password: pass, profileImage: profileImage, completion: { user in
            UserDefaults.standard.set(user.name, forKey: "user_name")
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func selectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
