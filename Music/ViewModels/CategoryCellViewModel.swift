class CategoryCellViewModel {
    private let category: Category

    public let name: String

    public var didSelectCategory: ((Category) -> ())?

    init(category: Category) {
        self.category = category
        self.name = category.name
    }

    public func selected() {
        self.didSelectCategory?(self.category)
    }
}