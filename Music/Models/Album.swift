struct Album: JSONParseable {
    let id: Int
    let artist: String
    let title: String
    let coverUrl: String
    let genre: String
    let tracks: [Song]

    static var song_id = 1

    init?(response: [String: AnyObject]) {
        let parser = JSONParser(response)

        do {
            id = try parser.fetch("id")
            artist = try parser.fetch("artist")
            title = try parser.fetch("title")
            let cover_url: String = try parser.fetch("coverUrl")
            coverUrl = cover_url
            genre = try parser.fetch("genre")

            let songs = response["tracks"] as! [String]

            tracks = songs.map { title in
                let song = Song(id: Album.song_id, title: title, coverUrl: cover_url)
                Album.song_id += 1 // "auto increment" song_id
                return song
            }
        } catch {
            return nil
        }
    }
}