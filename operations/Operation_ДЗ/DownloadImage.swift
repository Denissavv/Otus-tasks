import Foundation
import UIKit

let cache = NSCache<AnyObject, AnyObject>()

class DownloadImage: Operation {
    
    static let shared = DownloadImage()
    
    private var task: URLSessionTask?
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let imageFromCache = cache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            completion(imageFromCache)
            return
        }
        
        if let task = task {
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            cache.setObject(image, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task?.resume()
    }
}
