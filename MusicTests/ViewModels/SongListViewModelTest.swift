import XCTest

@testable import Music

class SongListViewModelTest: XCTestCase {
    func test_loadSongs_populatesSongCellViewModels() {
        let apiClient = APIClient(sessionManager: MockURLSession())
        let imageCache = ImageCache(apiClient: apiClient)
        let category = Category(id: 1, name: "Test", songIds: [1,2,3])

        let viewModel = SongListViewModel(apiClient: apiClient, imageCache: imageCache, category: category)
        XCTAssertGreaterThan(viewModel.songCellViewModels.count, 0)
    }
}
