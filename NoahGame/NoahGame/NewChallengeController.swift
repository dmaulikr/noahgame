//
//  NewChallengeController.swift
//  NoahGame
//
//  Created by Franklin Fox on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class NewChallengeController: UITableViewController {

    let cellId = "cellId"
    var personages = [Personage]()
    var source: SessionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Challenge"
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Session.shared.delegate = self
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
        
        let enemy = personages[indexPath.row]
        
        NoahService.shared.sendChallenge(to: enemy) {
            self.showWaitingAlert(enemy: enemy)
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func showWaitingAlert(enemy: Personage) {
        let alert = UIAlertController(title: "Challenge",
                                      message: "Waiting that \(enemy.name) will accept the challenge.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            NoahService.shared.cancelChallenge(to: enemy) { }
        })
        
        self.present(alert, animated: true, completion: nil)
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

extension NewChallengeController: SessionDelegate {
    
    func startChallenge(_ challenge: Challenge) {
        dismiss(animated: true) {
            self.dismiss(animated: true) {
                self.source?.startChallenge(challenge)
            }
        }
    }
    
}
