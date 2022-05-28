//
//  NetworkServiceTests.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import XCTest

class NetworkServiceTests: XCTestCase {


    func test_setupNetworkService() {
        // given
        let config = NetworkConfigurableMock()
        let expectedResponseData = "Test Response Data".data(using: .utf8)

        let sessionManager = NetworkSessionManagerMock(response: nil,
                                                       data: expectedResponseData,
                                                       error: nil)

        let service = NetworkServiceImpl(config: config,
                                         sessionManager: sessionManager,
                                         logger: NetworkLoggerImpl())
        let endpoint = EndpointMock(path: "https://test.com", method: .get)
        let expectation = self.expectation(description: "Correct response data expectation")

        //when
        service.request(endpoint: endpoint) { result in
            guard let responseData = try? result.get() else {
                XCTFail("Should return proper response")
                return
            }
            XCTAssertEqual(responseData, expectedResponseData)
            expectation.fulfill()
        }

        //then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_urlGenerationError() {
        // given
        let config = NetworkConfigurableMock()
        let testResponseData = "Test Response Data".data(using: .utf8)

        let sessionManager = NetworkSessionManagerMock(response: nil,
                                                       data: testResponseData,
                                                       error: nil)

        let service = NetworkServiceImpl(config: config,
                                         sessionManager: sessionManager,
                                         logger: NetworkLoggerImpl())

        let endpoint = EndpointMock(path: "this is invalid url", method: .get)
        let expectation = self.expectation(description: "Correct response data expectation")

        service.request(endpoint: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should throw url generation error")

            } catch let error {
                guard case NetworkError.urlGeneration = error else {
                    XCTFail("Should throw url generation error")
                    return
                }

                expectation.fulfill()
            }
        }

        //then
        wait(for: [expectation], timeout: 0.1)
    }
}

