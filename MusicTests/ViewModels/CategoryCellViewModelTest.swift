import XCTest

@testable import Music

class CategoryCellViewModelTest: XCTestCase {
    func test_nameProperty() {
        let category = Category(id: 1, name: "Test", songIds: [1,2,3])
        let viewModel = CategoryCellViewModel(category: category)
        XCTAssertEqual(viewModel.name, category.name)
    }
}
