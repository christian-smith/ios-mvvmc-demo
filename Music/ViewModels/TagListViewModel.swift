import Foundation

class TagListViewModel {
    private let apiClient: APIClient

    public var tagCellViewModels: [TagCellViewModel]

    public var didUpdate: ((TagListViewModel) -> ())?
    public var didSelectTag: ((Tag) -> ())?

    init(apiClient: APIClient) {
        self.apiClient = apiClient
        self.tagCellViewModels = [TagCellViewModel]()

        loadTags()
    }

    private func loadTags() {
        apiClient.getRequestSample(endpoint: .tags) { data, response, error in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data) as? [JSON]

                    guard let tags = jsonArray else {
                        return
                    }

                    for tagDictionary in tags {
                        if let tag = Tag(response: tagDictionary) {
                            let tagCellViewModel = self.createTagCellViewModel(tag: tag)
                            self.tagCellViewModels.append(tagCellViewModel)
                        }
                    }

                    self.didUpdate?(self)
                } catch {
                    print(error)
                }
            }
        }
    }

    private func createTagCellViewModel(tag: Tag) -> TagCellViewModel {
        let viewModel = TagCellViewModel(tag: tag)

        viewModel.didSelectTag = { [weak self] tag in
            self?.didSelectTag?(tag)
        }

        return viewModel
    }
}
