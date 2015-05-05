//: Playground - noun: a place where people can play

import Cocoa

struct Point {
    let x: Double
    let y: Double

    static let zero = Point(x: 0, y: 0)

    static var ones: [Point] {
        return [Point(x: 1, y: 1),
                Point(x: -1, y: 1),
                Point(x: 1, y: -1),
                Point(x: -1, y: -1)]
    }

    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

class MyClass {
    static var bar: NSObject?
}