//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Sapozhnik Ivan on 24.08.16.
//  Copyright © 2016 Sapozhnik Ivan. All rights reserved.
//

import XCTest
@testable import iTunesSearch

class iTunesSearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
	
	func testFetchArtistDataShouldReturnListOfSongs() {
		
		let expectation = expectationWithDescription("Wait for artistByName() to return")
		APIService.artistByName("Pendulum", success: { (data) in
			expectation.fulfill()
			XCTAssertNotNil(data, "Songs array should not be nil")
			XCTAssertGreaterThan(data.count, 0, "Songs count should be greater than 0")
			}) { (error) in
				expectation.fulfill()
				XCTAssertNil(error, "Error should be nil")
		}
		
		self.waitForExpectationsWithTimeout(2.0, handler: { error in
			XCTAssertNil(error, "Something went wrong")
		})
	}
	
}
