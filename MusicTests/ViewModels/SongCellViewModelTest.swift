import XCTest

@testable import Music

class SongCellViewModelTest: XCTestCase {
    var imageCache: ImageCache!

    override func setUp() {
        super.setUp()

        let apiClient = APIClient(sessionManager: MockURLSession())
        imageCache = ImageCache(apiClient: apiClient)
    }

    func test_titleProperty() {
        let song = Song(id: 1, title: "test", coverUrl: "https://localhost/cover.jpg")
        let viewModel = SongCellViewModel(imageCache: imageCache, song: song)
        XCTAssertEqual(viewModel.title, song.title)
    }

    func test_loadsAlbumImage() {
        let song = Song(id: 1, title: "test", coverUrl: "https://localhost/cover.jpg")
        imageCache.add(path: song.coverUrl, image: UIImage())
        let viewModel = SongCellViewModel(imageCache: imageCache, song: song)
        viewModel.loadAlbumImage()
        XCTAssertNotNil(viewModel.image)
    }
}
