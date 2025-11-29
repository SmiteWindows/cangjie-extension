import XCTest
import SwiftTreeSitter
import TreeSitterYes

final class TreeSitterYesTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_yes())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading yes grammar")
    }
}
