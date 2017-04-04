import XCTest

@testable import Music

class ImageCacheTests: XCTestCase {
    var mockSession: MockURLSession!
    var imageCache: ImageCache!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        imageCache = ImageCache(apiClient: APIClient(sessionManager: mockSession))
    }

    func testLoad_shouldMakeNetworkRequest_whenNotCached() {
        imageCache.load(path: "https://localhost/image.jpg") { image in  }
        XCTAssertTrue(mockSession.dataTaskWasCalled)
    }

    func testLoad_shouldNotMakeNetworkRequest_whenCached() {
        let path = "https://localhost/image.jpg"
        imageCache.add(path: path, image: UIImage())
        imageCache.load(path: path) { image in  }
        XCTAssertFalse(mockSession.dataTaskWasCalled)
    }
}
