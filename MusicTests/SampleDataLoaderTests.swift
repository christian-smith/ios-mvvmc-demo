import XCTest

@testable import Music

class FixtureDataLoaderTests : XCTestCase {
    var dataLoader: SampleDataLoader!

    override func setUp() {
        super.setUp()
        dataLoader = SampleDataLoader()
    }

    func test_loadsAlbums() {
        XCTAssertEqual(dataLoader.albums.count, 7)
    }

    func test_multi() {
        let dataLoader = SampleDataLoader()
        let albums = dataLoader.albums[0..<3]
        let tracks = albums.last!.tracks[0..<3]
        let songs = dataLoader.multi(songIds: tracks.map { $0.id })
        let multiSongs = try! JSONSerialization.jsonObject(with: songs!) as! [[String: Any]]
        XCTAssertEqual(multiSongs.count, 3)
    }

    func test_categories() {
        let categoriesData = dataLoader.categories(tagId: 1)
        let categories = try! JSONSerialization.jsonObject(with: categoriesData!) as! [[String: Any]]
        XCTAssertGreaterThan(categories.count, 0)
    }
}
