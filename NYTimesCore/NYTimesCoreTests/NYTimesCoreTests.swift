//
//  NYTimesCoreTests.swift
//  NYTimesCoreTests
//
//  Created by Nanjunda Swamy on 17/07/19.
//  Copyright © 2019 Nanjunda Swamy. All rights reserved.
//

import XCTest
@testable import NYTimesCore

class NYTimesCoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let expectation = self.expectation(description: "articles")
        
        DataManager.sharedInstance.getViewedArticles(period: "1", params: nil) { (result) in
            
            
            assert(result.isSuccess)
            XCTAssertTrue(result.value?.first?.id != nil)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 60)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
