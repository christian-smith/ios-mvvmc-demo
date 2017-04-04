import XCTest

@testable import Music

class TagCellViewModelTests: XCTestCase {
    func test_titleProperty() {
        let tag = Tag(id: 1, title: "test")
        let viewModel = TagCellViewModel(tag: tag)
        XCTAssertEqual(viewModel.title, tag.title)
    }
}
