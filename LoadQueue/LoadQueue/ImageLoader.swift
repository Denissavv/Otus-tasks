import UIKit

class ImageLoader: NSObject {
    
    private class ImageLoadOperation: Operation {
        let imageUrl: URL
        let completion: (UIImage?) -> Void
        
        init(imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
            self.imageUrl = imageUrl
            self.completion = completion
            super.init()
        }
        
        override func main() {
            if isCancelled {
                return
            }
            
            do {
                let imageData = try Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                
                if isCancelled {
                    return
                }
                
                completion(image)
            } catch {
                print("Error loading image: \(error)")
                completion(nil)
            }
        }
    }
    
    private let imageLoadQueue = OperationQueue()
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    func loadImage(forEntity entity: YourEntityType, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: entity.imageUrl as NSURL) {
            completion(cachedImage)
            return
        }
        
        let imageLoadOperation = ImageLoadOperation(imageUrl: entity.imageUrl) { [weak self] (image) in
            guard let self = self else { return }
            
            if let image = image {
                self.imageCache.setObject(image, forKey: entity.imageUrl as NSURL)
            }
            
            completion(image)
        }
        
        imageLoadQueue.addOperation(imageLoadOperation)
    }
}


struct YourEntityType {
    let imageUrl: URL
    let isLoaded: Bool
}




func loadImageForEntities() {
    let imageLoader = ImageLoader()
    let entity1 = YourEntityType(imageUrl: URL(string: "https://t4.ftcdn.net/jpg/00/53/45/31/360_F_53453175_hVgYVz0WmvOXPd9CNzaUcwcibiGao3CL.jpg")!, isLoaded: false)
    let entity2 = YourEntityType(imageUrl: URL(string: "https://t4.ftcdn.net/jpg/03/16/68/69/360_F_316686992_OvCTP1wfazJhBeMrBBDUGooufSmj2O8G.jpg")!, isLoaded: false)

    imageLoader.loadImage(forEntity: entity1) { (image) in
        if let loadedImage = image {
            DispatchQueue.main.async {
                let imageView1 = UIImageView(image: loadedImage)
            }
        } else {
            print("Failed to load image for entity1")
        }
    }

    
    imageLoader.loadImage(forEntity: entity2) { (image) in
        if let loadedImage = image {
            DispatchQueue.main.async {
                let imageView2 = UIImageView(image: loadedImage)
            }
        } else {
            print("Failed to load image for entity2")
        }
    }
}

