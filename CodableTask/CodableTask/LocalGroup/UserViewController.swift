import UIKit

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the table view
        tableView.dataSource = self
        tableView.delegate = self

        // Fetch users from the network
        let networkLayer = UrlSessinNetworkLayer()
        networkLayer.getUsers { result in
            switch result {
            case .success(let users):
                // Update the users array and reload the table view on the main thread
                DispatchQueue.main.async {
                    self.users = users
                    self.tableView.reloadData()
                }
            case .failure(let error):
                // Handle the failure case (display an error message, etc.)
                print("Error: \(error)")
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = users[indexPath.row]

        // Configure the cell with user data
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.userName

        return cell
    }

    // Add any other UITableViewDelegate methods as needed

}

