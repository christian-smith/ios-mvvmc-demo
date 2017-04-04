class TagCellViewModel {
    private let tag: Tag

    public let title: String

    public var didSelectTag: ((Tag) -> ())?

    init(tag: Tag) {
        self.tag = tag
        self.title = tag.title
    }

    func selected() {
        self.didSelectTag?(self.tag)
    }
}