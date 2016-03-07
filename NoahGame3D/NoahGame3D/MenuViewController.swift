//
//  MenuViewController.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 7/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "menuToGameSegue" {
            let game = segue.destinationViewController as! GameViewController
            
            if userName.text != nil {
                game.userName = userName.text
            } else {
                game.userName = "User Name"
            }
        }
    }

}
