import XCTest

@testable import Music

class CategoryListViewModelTest: XCTestCase {
    func test_loadCategories() {
        let tagsData = SampleDataLoader().tags()
        let tagsArray = try! JSONSerialization.jsonObject(with: tagsData!) as! [JSON]
        let tag = Tag(response: tagsArray.first!)
        let viewModel = CategoryListViewModel(apiClient: APIClient(), tag: tag!)
        XCTAssertGreaterThan(viewModel.categoryCellViewModels.count, 0)
    }
}
