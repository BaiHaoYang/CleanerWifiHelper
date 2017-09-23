//
//  CleanerWiFiHelperTests.swift
//  CleanerWiFiHelperTests
//
//  Created by Ke Yang on 02/12/2016.
//  Copyright © 2016 com.sangebaba. All rights reserved.
//

import XCTest
@testable import CleanerWiFiHelper

class CleanerWiFiHelperTests: XCTestCase {

	var ssid = "Xiuxiu2G"
	var password = "xiuxiu910"
	var helper: CleanerWiFiHelper?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExample() {
        let expect = expectation(description: "config wifi for cleaner shall be successful")
		helper = CleanerWiFiHelper()
		helper?.sendData(ssid: ssid, password: password, success: { (info) in
			print(info.mac)
			XCTAssertTrue(true)
			expect.fulfill()
		}, failure: { (error) in
			XCTAssertTrue(false)
			expect.fulfill()
		})
		waitForExpectations(timeout: 45.0) { (error) in
			if let err = error {
				XCTFail("\(err)")
			}
		}
    }

}

// 3DTouch from lineChart
