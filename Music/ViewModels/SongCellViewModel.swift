import UIKit

class SongCellViewModel {
    private let imageCache: ImageCache
    private let song: Song

    public var title: String
    public var image: UIImage?

    public var didUpdate: (() -> ())?

    init(imageCache: ImageCache, song: Song) {
        self.imageCache = imageCache
        self.song = song
        self.title = song.title
    }

    public func loadAlbumImage() {
        imageCache.load(path: song.coverUrl, completion: { [weak self] image in
            guard let strongSelf = self else { return }

            strongSelf.image = image
            strongSelf.didUpdate?()
        })
    }
}
