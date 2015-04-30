//: Playground - noun: a place where people can play

import UIKit

func sum(input: Int...) -> Int {
    return input.reduce(0, combine: +)
}

sum(1,2,3,4,5)