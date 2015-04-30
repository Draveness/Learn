//: Playground - noun: a place where people can play

import UIKit

protocol KittenLike {
    func meow() -> String
}

protocol DogLike {
    func bark() -> String
}

protocol TigerLike {
    func aou() -> String
}

typealias PetLike = protocol<KittenLike, DogLike>
typealias CatLike = protocol<KittenLike, TigerLike>
class MysteryAnimal: CatLike, DogLike, TigerLike {
    func meow() -> String {
        return "meow"
    }

    func bark() -> String {
        return "bark"
    }

    func aou() -> String {
        return "aou"
    }
}

protocol A {
    func bar() -> Int
}

protocol B {
    func bar() -> String
}

class Class: A, B {
    func bar() -> Int {
        return 1
    }

    func bar() -> String {
        return "Hi"
    }
}

let instance = Class()

let num = (instance as A).bar()
let num = (instance as B).bar()
