import Foundation

@testable import Music

class MockURLSession: URLSessionProtocol {
    var dataTaskWasCalled = false

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTaskWasCalled = true
        return MockURLSessionDataTask()
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTaskProtocol {
        dataTaskWasCalled = true
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
}
