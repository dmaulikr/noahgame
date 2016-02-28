//
//  KnightTests.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import XCTest
import NoahKit

class KnightTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let knight = Knight()
        knight.name = "Knight"
        
        XCTAssertEqual(knight.name, "Knight")
    }

}
