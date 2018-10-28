
import XCTest
@testable import Sixsmith

struct DataSource: HexagonGroupDataSource {
    var coordinateSystem: CoordinateSystem {
        return .increaseTowardBottomRight
    }
    var groupOrigin: Vector2 {
        return Vector2(0, 0)
    }
    var groupShape: GroupShape {
        return .hexagon(radius: 15)
    }
    var hexagonSize: Double {
        return 5
    }
    var hexagonScaleFactor: Double {
        return 1
    }
    var hexagonOrientation: Orientation

    init(_ orientation: Orientation = Orientation.flat) {
        hexagonOrientation = orientation
    }
}

class HexConversionTests: XCTestCase {
    func testOriginHexConvertsToOriginScreen() {
        let hex = Hex(q: 0, r: 0, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          dataSource: DataSource())
        XCTAssertEqual(pixel.x, 0)
        XCTAssertEqual(pixel.y, 0)
    }

    func testFlatHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          dataSource: DataSource())
        XCTAssertEqual(Int(pixel.x), 7)
        XCTAssertEqual(Int(pixel.y), -4)
    }

    func testPointedHexConvertsToScreen() {
        let hex = Hex(q: 1, r: -1, s: 0)
        let pixel = Conversion.hexToPixel(hex,
                                          dataSource: DataSource(Orientation.pointed))
        XCTAssertEqual(Int(pixel.x), 4)
        XCTAssertEqual(Int(pixel.y), -7)
    }

    func testOriginScreenToHexConversion() {
        let touchPosition = Vector2(0, 0)
        let hex = Conversion.pixelToHex(touchPosition,
                                        dataSource: DataSource(Orientation.pointed))
        XCTAssertEqual(hex, Hex(q: 0, r: 0, s: 0))
    }

    func testRandomScreenToHexConversion() {
        let touchPosition = Vector2(3.56, -42.081)
        let hex = Conversion.pixelToHex(touchPosition,
                                        dataSource: DataSource(Orientation.pointed))
        XCTAssertEqual(hex, Hex(q: 3, r: -6, s: 3))
    }
}
