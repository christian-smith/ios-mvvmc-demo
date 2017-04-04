struct Tag: JSONParseable {
    let id: Int
    let title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }

    init?(response: [String: AnyObject]) {
        let parser = JSONParser(response)

        do {
            id = try parser.fetch("id")
            title = try parser.fetch("title")
        } catch {
            return nil
        }
    }
}
