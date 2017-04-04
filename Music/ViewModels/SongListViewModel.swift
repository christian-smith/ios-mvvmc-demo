import Foundation

class SongListViewModel {
    private let apiClient: APIClient
    private let imageCache: ImageCache
    private let category: Category

    public var didUpdate: ((SongListViewModel) -> ())?
    public var didSelectSong: ((Song) -> ())?
    public var songCellViewModels = [SongCellViewModel]()

    init(apiClient: APIClient, imageCache: ImageCache, category: Category) {
        self.apiClient = apiClient
        self.imageCache = imageCache
        self.category = category

        loadSongs()
    }

    private func loadSongs() {
        apiClient.getRequestSample(endpoint: .multi(category.songIds)) { data, response, error in
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data) as? [JSON]

                    guard let songs = jsonArray else {
                        return
                    }

                    for songDictionary in songs {
                        if let song = Song(response: songDictionary) {
                            let songCellViewModel = self.createSongCellViewModel(song: song)
                            self.songCellViewModels.append(songCellViewModel)
                        }
                    }

                    self.didUpdate?(self)
                } catch {
                    print(error)
                }
            }
        }
    }

    private func createSongCellViewModel(song: Song) -> SongCellViewModel {
        let viewModel = SongCellViewModel(imageCache: imageCache, song: song)
        return viewModel
    }
}
