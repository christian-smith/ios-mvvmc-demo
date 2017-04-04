import Foundation

typealias EndpointCompletion = ( Data?, URLResponse?, Error?) -> ()

enum Endpoint {
    case tags
    case categories(Int)
    case multi(Array<Int>)
    case image(String)
}

protocol Path {
    var path : String { get }
    var baseURL: URL { get }
    var sampleData: Data? { get }
    func url() -> URL
}

extension Endpoint: Path {
    var baseURL: URL { return URL(string: Constants.baseURL)! }
    var path: String {
        switch self {
        case .tags: return "/tags"
        case .categories(let tagId): return "/category/tag/\(tagId)"
        case .multi(let songIds):
            let queryItems = songIds.map {
                URLQueryItem.init(name: "id", value: String($0))
            }

            let url = NSURLComponents.init(string: "/songs/multi")
            url?.queryItems = queryItems
            return url!.path!

        case .image(let url): return url
        }
    }

    var sampleData: Data? {
        let dataLoader = SampleDataLoader.instance

        switch self {
        case .tags: return dataLoader.tags()
        case .categories(let tagId): return dataLoader.categories(tagId: tagId)
        case .multi(let songIds): return dataLoader.multi(songIds: songIds)
        case .image(_): return nil
        }
    }

    func url() -> URL {
        switch self {
        case .image: return URL(string: self.path)!
        default: return self.baseURL.appendingPathComponent(self.path)
        }
    }
}

class APIClient {
    let sessionManager: URLSessionProtocol

    init(sessionManager: URLSessionProtocol = URLSession.shared) {
        self.sessionManager = sessionManager
    }

    public func getRequestSample(endpoint: Endpoint, completion: @escaping EndpointCompletion) {
        return completion(endpoint.sampleData, nil, nil)
    }

    public func getRequest(endpoint: Endpoint, completion: @escaping EndpointCompletion) -> Void {
        var request = URLRequest(url: endpoint.url())
        request.httpMethod = "GET"
        let task = sessionManager.dataTask(with: request) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }

        task.resume()
    }
}
