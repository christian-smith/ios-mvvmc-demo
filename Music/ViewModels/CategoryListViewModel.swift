import Foundation

class CategoryListViewModel {
    private let apiClient: APIClient
    private let tag: Tag

    public var didUpdate: ((CategoryListViewModel) -> ())?
    public var didSelectCategory: ((Category) -> ())?
    public var categoryCellViewModels = [CategoryCellViewModel]()

    init(apiClient: APIClient, tag: Tag) {
        self.apiClient = apiClient
        self.tag = tag

        loadCategories()
    }

    private func loadCategories() {
        apiClient.getRequestSample(endpoint: .categories(tag.id)) { data, response, error in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data) as? [JSON]

                    guard let categories = jsonArray else {
                        return
                    }

                    for categoriesDictionary in categories {
                        if let category = Category(response: categoriesDictionary) {
                            let categoryCellViewModel = self.createCategoryCellViewModel(category: category)
                            self.categoryCellViewModels.append(categoryCellViewModel)
                        }
                    }

                    self.didUpdate?(self)
                } catch {
                    print(error)
                }
            }
        }
    }

    private func createCategoryCellViewModel(category: Category) -> CategoryCellViewModel {
        let viewModel = CategoryCellViewModel(category: category)

        viewModel.didSelectCategory = { [weak self] category in
            self?.didSelectCategory?(category)
        }

        return viewModel
    }
}
