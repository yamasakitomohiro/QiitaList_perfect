//
//  WebApiTests.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/06/28.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import XCTest
import OHHTTPStubs


class WebApiTests: XCTestCase {
    let URL_STATUS_200 = "http://200"
    let URL_STATUS_400 = "http://400"
    let URL_STATUS_500 = "http://500"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.absoluteString == self.URL_STATUS_200}) { _ in
            let stubPath = OHPathForFile("response.json", self.dynamicType)
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"text/plain"]
                )
                .requestTime(0, responseTime:OHHTTPStubsDownloadSpeed3G)
        }

        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.absoluteString == self.URL_STATUS_400}) { _ in
            let stubPath = OHPathForFile("response.json", self.dynamicType)
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 400,
                headers: ["Content-Type":"text/plain"]
                )
                .requestTime(0, responseTime:OHHTTPStubsDownloadSpeed3G)
        }
        
        OHHTTPStubs.stubRequestsPassingTest({$0.URL!.absoluteString == self.URL_STATUS_500}) { _ in
            let stubPath = OHPathForFile("response.json", self.dynamicType)
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 500,
                headers: ["Content-Type":"text/plain"]
                )
                .requestTime(0, responseTime:OHHTTPStubsDownloadSpeed3G)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testJsonObject() {
        // This is an example of a functional test case.
        
        
        
        
        let expectStatus200 = self.expectationWithDescription("status:200")
        WebApi.jsonObject(self.URL_STATUS_200, complated: { (jsonObject:AnyObject?) -> Void in
            XCTAssertNotNil(jsonObject)
            expectStatus200.fulfill()
        })
        
        let expectStatus400 = self.expectationWithDescription("status:400")
        WebApi.jsonObject(self.URL_STATUS_400, complated: { (jsonObject:AnyObject?) -> Void in
            XCTAssertNil(jsonObject)
            expectStatus400.fulfill()
        })
        
        let expectStatus500 = self.expectationWithDescription("status:500")
        WebApi.jsonObject(self.URL_STATUS_500, complated: { (jsonObject:AnyObject?) -> Void in
            XCTAssertNil(jsonObject)
            expectStatus500.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(1, handler: { (error) -> Void in
        })
    }


}
