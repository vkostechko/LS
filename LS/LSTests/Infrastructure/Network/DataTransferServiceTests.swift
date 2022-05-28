//
//  DataTransferServiceTests.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import XCTest

class DataTransferServiceTests: XCTestCase {

    private struct MockModel: Decodable {
        let name: String
    }

    func test_decodeResponseSuccessfully() {
        //given

        let expectation = self.expectation(description: "Should decode mock object")

        let config = NetworkConfigurableMock()

        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        let sessionManager = NetworkSessionManagerMock(response: nil,
                                                       data: responseData,
                                                       error: nil)

        let networkService = NetworkServiceImpl(config: config,
                                                sessionManager: sessionManager,
                                                logger: NetworkLoggerImpl())

        let endpoint = Endpoint<MockModel>(path: "https://test.com",
                                           method: .get,
                                           queryParametersEncodable: nil)

        let dataTransferService = DataTransferServiceImpl(with: networkService)

        //when
        dataTransferService.request(with: endpoint) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        
        //then
        wait(for: [expectation], timeout: 0.1)
    }

    func test_badRequestReceived() {
        //given
        let expectation = self.expectation(description: "Should throw network error")

        let config = NetworkConfigurableMock()

        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let sessionManager = NetworkSessionManagerMock(response: response,
                                                       data: responseData,
                                                       error: nil)

        let networkService = NetworkServiceImpl(config: config,
                                                sessionManager: sessionManager,
                                                logger: NetworkLoggerImpl())

        let endpoint = Endpoint<MockModel>(path: "https://test.com",
                                           method: .get,
                                           queryParametersEncodable: nil)

        let dataTransferService = DataTransferServiceImpl(with: networkService)

        //when
        dataTransferService.request(with: endpoint) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")

            } catch let error {

                print(error)

                if case DataTransferError.parsing = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Wrong error")
                }
            }
        }

        //then
        wait(for: [expectation], timeout: 0.1)
    }
}
