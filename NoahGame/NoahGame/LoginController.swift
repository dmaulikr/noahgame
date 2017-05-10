//
//  LoginController.swift
//  NoahGame
//
//  Created by Franklin Fox on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        profileImage.isUserInteractionEnabled = true
    }

    @IBAction func signIn(_ sender: Any) {
        guard let emailt = email.text, let pass = password.text else {
            print("Form is not valid")
            return
        }
        
        NoahService.shared.signIn(emailt, password: pass) { user in
            self.initSession(withUser: user)
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let namet = name.text,
            let emailt = email.text,
            let pass = password.text,
            let image = profileImage.image else {
            print("Form is not valid")
            return
        }
            
        NoahService.shared.signUp(namet, email: emailt, password: pass, profileImage: image) { user in
            self.initSession(withUser: user)
        }
    }
    
    func initSession(withUser user: User) {
        Session.shared.user = user
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func selectProfileImage() {
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
            profileImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
