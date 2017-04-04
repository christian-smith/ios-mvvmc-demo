import XCTest

@testable import Music

class APIClientTests: XCTestCase {
    var mockSession: MockURLSession!
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        apiClient = APIClient(sessionManager: mockSession)
    }

    func test_getRequest_makesNotworkCalls() {
        apiClient.getRequest(endpoint: .tags) { data, response, error in  }
        XCTAssertTrue(mockSession.dataTaskWasCalled)
    }

    func test_getRequestSample_doesNotMakeNetworkCalls() {
        apiClient.getRequestSample(endpoint: .tags) { data, response, error in  }
        XCTAssertFalse(mockSession.dataTaskWasCalled)
    }

    func test_endpointUrl_returnsValidUrl() {
        let url = URL(string: Constants.baseURL)!.appendingPathComponent("/tags")
        let testUrl = Endpoint.tags.url()
        XCTAssert(url == testUrl)
    }
}

