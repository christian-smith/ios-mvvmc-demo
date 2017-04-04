import Foundation

class SampleDataLoader {
    static let instance = SampleDataLoader()

    var albums = [Album]()
    var categories = [Category]()

    init() {
        loadAlbums()
        loadCategories()
    }

    public func tags() -> Data? {
        return loadJson(filename: "tags")
    }

    public func categories(tagId: Int) -> Data? {
        let filteredCategories = categories.filter { $0.id == tagId }
        let jsonArray = filteredCategories.map { $0.toJSON() } as! [String]
        let jsonString = jsonArray.joined(separator: ",")
        return "[ \(jsonString) ]".data(using: .utf8)
    }

    public func multi(songIds: [Int]) -> Data? {
        let allSongs = albums.flatMap { $0.tracks }
        let filteredSongs = allSongs.filter { songIds.contains($0.id) }
        let json = filteredSongs.map { $0.toJSON() } as! [String]
        let jsonString = json.joined(separator: ",")
        return "[ \(jsonString) ]".data(using: .utf8)
    }

    private func loadAlbums() {
        let albumsData = loadJson(filename: "albums")

        do {
            let albumsArray = try JSONSerialization.jsonObject(with: albumsData!) as! [[String: AnyObject]]

            for album in albumsArray {
                if let album = Album(response: album) {
                    albums.append(album)
                }
            }
        } catch {
            print(error)
        }
    }

    private func loadCategories() {
        var genresDictionary = [String: [Int]]()
        var albumDictionary = [String: [Int]]()
        var artistDictionary = [String: [Int]]()

        for album in albums {
            let songIds = album.tracks.map { $0.id }

            if artistDictionary[album.artist] != nil {
                artistDictionary[album.artist]! += songIds
            } else {
                artistDictionary[album.artist] = songIds
            }

            if albumDictionary[album.title] != nil {
                albumDictionary[album.title]! += songIds
            } else {
                albumDictionary[album.title] = songIds
            }

            if genresDictionary[album.genre] != nil {
                genresDictionary[album.genre]! += songIds
            } else {
                genresDictionary[album.genre] = songIds
            }
        }

        for (key, value) in artistDictionary {
            let category = Category(id: 1, name: key, songIds: value)
            categories.append(category)
        }

        for (key, value) in albumDictionary {
            let category = Category(id: 2, name: key, songIds: value)
            categories.append(category)
        }

        for (key, value) in genresDictionary {
            let category = Category(id: 3, name: key, songIds: value)
            categories.append(category)
        }
    }

    private func loadJson(filename: String) -> Data? {
        do {
            let path = Bundle.main.path(forResource: filename, ofType: "json")
            let json = try String(contentsOf: URL(fileURLWithPath: path!))
            return json.data(using: .utf8)
        } catch {
            return nil
        }
    }
}
