import UIKit

class ImageCache {
    private var cache = [String: UIImage]()
    private let apiClient: APIClient

    required init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func load(path: String, completion: @escaping (UIImage) -> Void) {
        if let existing = cache[path] {
            completion(existing)
            return
        }

        return self.apiClient.getRequest(endpoint: .image(path)) { [weak self] data, response, error in
            guard let strongSelf = self else { return }

            if let data = data, let image = UIImage(data: data) {
                strongSelf.add(path: path, image: image)
                completion(image)
            }
        }
    }

    public func add(path: String, image: UIImage) {
        cache[path] = image
    }
}
