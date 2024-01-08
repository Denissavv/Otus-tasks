

import UIKit

class PostDetailsViewController: UIViewController {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userName: UILabel!
    
    var name: String?
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            nameLabel.text = "Name: \(name)"
        }
        
        if let username = userName {
            userName.text = "UserName: \(username)"
        }
    }
}
