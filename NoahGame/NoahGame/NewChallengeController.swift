//
//  NewChallengeController.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class NewChallengeController: UITableViewController {

    let cellId = "cellId"
    var personages = [Personage]()
    var source: MainController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        tableView.register(PersonageCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        fetchPersonages()
    }
    
    func fetchPersonages() {
        let myName = Session.shared.personage?.name
        
        NoahService.shared.fetchPersonage({ personage in
            
            if personage.name != myName {
                
                self.personages.append(personage)
                self.personages = self.personages.sorted {
                    return $0.name < $1.name
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        })
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PersonageCell
        
        cell.personage = personages[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { 
            let personage = self.personages[indexPath.row]
            self.source?.showGameController(withPersonage: personage)
        }
    }

}


class PersonageCell: UITableViewCell {
    
    var personage: Personage? {
        didSet {
            textLabel?.text = personage?.name
            
            if let level = personage?.level {
                detailTextLabel?.text = "Level: \(level)"
            }
            
            profileImageView.image = #imageLiteral(resourceName: "default")
            
//            if let profileImageUrl = user?.profileImageUrl {
//                profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
//            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame.origin = CGPoint(x: 56, y: textLabel!.frame.origin.y)
        detailTextLabel?.frame.origin = CGPoint(x: 56, y: detailTextLabel!.frame.origin.y)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
