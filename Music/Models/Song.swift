struct Song: JSONSerializable {
    let id: Int
    let title: String
    let coverUrl: String

    init(id: Int, title: String, coverUrl: String) {
        self.id = id
        self.title = title
        self.coverUrl = coverUrl
    }

    init?(response: JSON) {
        let parser = JSONParser(response)

        do {
            id = try parser.fetch("id")
            title = try parser.fetch("title")
            coverUrl = try parser.fetch("coverUrl")
        } catch {
            return nil
        }
    }

}
