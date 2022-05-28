//
//  FoodShakeViewModelTests.swift
//  LSTests
//
//  Created by Viachaslau Kastsechka on 5/28/22.
//

import XCTest

class FoodShakeViewModelTests: XCTestCase {

    func testShakeDevice() throws {
        // given

        let product = FoodProduct.stub()

        let useCase = FoodShakeUseCaseMock()
        useCase.expectation = self.expectation(description: "Get Product on device shake motion")
        useCase.product = product

        let viewModel = FoodShakeViewModel(useCase: useCase, actions: nil)

        // when
        viewModel.didShakeDevice()
        
        //then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.foodName.value, product.title)
        XCTAssertTrue(viewModel.isDataLoaded.value)
    }
}
