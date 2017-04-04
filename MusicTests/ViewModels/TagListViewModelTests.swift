import XCTest

@testable import Music

class TagListViewModelTests: XCTestCase {
    func test_loadTags() {
        let tagListViewModel = TagListViewModel(apiClient: APIClient())
        XCTAssertEqual(tagListViewModel.tagCellViewModels.count, 3)
    }
}
