//
//  ViewController.swift
//  nav_test_9
//
//  Created by Денис on 07.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    var users: [User] = [] {
           didSet {
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }
    
    override func viewDidLoad() {
            super.viewDidLoad()

            tableView.delegate = self
            tableView.dataSource = self

            fetchData()
        }
    
    func fetchData() {
          let networkLayer = UrlSessinNetworkLayer()
          networkLayer.getUsers { result in
              switch result {
              case .success(let fetchedUsers):
                  self.users = fetchedUsers
              case .failure(let error):
                  print("Error: \(error)")
              }
          }
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "DetailsSegueId",
            let detailViewController = segue.destination as? PostDetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow
            else {
                return
        }
        
        let selectedUserData = users[indexPath.row]
        detailViewController.name = selectedUserData.name
        detailViewController.username = selectedUserData.userName
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    struct userData  {
        let name: String;
        let userName: String
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]

                let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell

                cell.name.text = user.name
                cell.username.text = user.userName
        
        
                print(cell)

                return cell
    }
}
