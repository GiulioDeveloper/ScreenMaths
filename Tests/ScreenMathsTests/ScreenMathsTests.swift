import XCTest
@testable import ScreenMaths

final class ScreenMathsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ScreenMaths().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
