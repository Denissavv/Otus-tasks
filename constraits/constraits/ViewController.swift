import UIKit

class ViewController: UIViewController {

    let label1 = UILabel()
    let imageViewBetweenLabels = UIImageView(image: UIImage(systemName: "heart.fill"))
    let label2 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen

        
        label1.text = "Label 1"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label1.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        
        label2.text = "Label 2"
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label2.setContentHuggingPriority(.defaultLow, for: .horizontal)

        
        imageViewBetweenLabels.contentMode = .scaleAspectFit
        imageViewBetweenLabels.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(label1)
        view.addSubview(imageViewBetweenLabels)
        view.addSubview(label2)

        
        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
        ])

        
        NSLayoutConstraint.activate([
            imageViewBetweenLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageViewBetweenLabels.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: view.frame.height / 10 * -1),
            imageViewBetweenLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewBetweenLabels.widthAnchor.constraint(equalToConstant: 20),
        ])

    
        NSLayoutConstraint.activate([
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }

            self.updateConstraintsForOrientation(size: size)
        }, completion: nil)
    }

    func updateConstraintsForOrientation(size: CGSize) {
        view.removeConstraints(view.constraints)
        
        NSLayoutConstraint.activate([
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
        ])

        
        NSLayoutConstraint.activate([
            imageViewBetweenLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageViewBetweenLabels.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: view.frame.height / 10 * -1),
            imageViewBetweenLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])

        
        NSLayoutConstraint.activate([
            label2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
        ])
    }
}
