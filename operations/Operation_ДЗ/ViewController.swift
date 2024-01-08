import UIKit

final class ViewController: UIViewController {
    
    private let imageURLs = [
    "https://cdn.theatlantic.com/thumbor/5oL1jeSM1DqwA604GQTMp4PV5Jg=/0x0:4800x2700/1600x900/media/img/mt/2023/10/zebras_1/original.jpg",
    "https://www.dartmoorzoo.org.uk/wp-content/uploads/2021/01/Tiger-1.jpg",
        "https://media.wired.com/photos/593261cab8eb31692072f129/master/pass/85120553.jpg",
    "https://images.squarespace-cdn.com/content/v1/60e9563bcb7b5401bb351c76/c8723f2d-7397-4c3e-89a8-17d7f762486b/20+Animals+A+shoot+2+HR-153.jpg"
    ]
    
    private var imagesArray = [UIImage]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellID)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        DownloadImage.shared.start()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellID, for: indexPath) as? CustomTableViewCell else {
              return UITableViewCell()
          }
          cell.selectionStyle = .none
          
          if let url = URL(string: imageURLs[indexPath.row]) {
              cell.customImageView.loadImage(url)
          }
          return cell
      }
  }

