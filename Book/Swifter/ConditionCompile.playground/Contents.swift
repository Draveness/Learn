//: Playground - noun: a place where people can play

import Cocoa

#if os(OSX)
    typealias Color = NSColor
#else
    typealias Color = UIColor
#endif