struct Category: JSONSerializable {
    let id: Int
    let name: String
    let songIds: [Int]

    init(id: Int, name: String, songIds: [Int]) {
        self.id = id
        self.name = name
        self.songIds = songIds
    }

    init?(response: JSON) {
        let parser = JSONParser(response)

        do {
            id = try parser.fetch("id")
            name = try parser.fetch("name")
            songIds = try parser.fetch("songIds")
        } catch {
            return nil
        }
    }
}