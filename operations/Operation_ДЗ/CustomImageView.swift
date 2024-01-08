
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionTask!
    var operationQueue = OperationQueue()
    var operation = Operation()
    
    func loadImage(_ url: URL) {
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        operationQueue.addOperation {
            
            if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
                DispatchQueue.main.async {
                    self.image = imageFromCache
                }
                return
            }
            
            self.task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            })
            self.task.resume()
        }
    }

}
