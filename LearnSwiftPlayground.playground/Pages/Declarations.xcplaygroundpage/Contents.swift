//: [Previous](@previous)

import Foundation


// Type Alias Declaration

typealias StringDictionary<Value> = Dictionary<String, Value>
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]
type(of: dictionary1) == type(of: dictionary2);


typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>;


protocol Sequence {
    associatedtype Iterator: IteratorProtocol;
    typealias Element = Iterator.Element;
}
func sum<T: Sequence>(_ sequence: T) -> Int
    where T.Element == Int {
        
    return 1;
}


// Rethrowing Functions and Methods

func someFunction(callback: () throws -> Void) rethrows {
    try callback();
}


// Enumerations with Cases of a Raw-Value Type

enum ExampleEnum: Int {
    case a, b, c = 5, d
}
ExampleEnum.a
ExampleEnum.a.rawValue
ExampleEnum.b.rawValue
ExampleEnum.c.rawValue
ExampleEnum.d.rawValue


enum GamePlayMode: String {
    case cooperative, individual, competitive = "abc"
}
GamePlayMode.cooperative.rawValue
GamePlayMode.competitive
GamePlayMode.competitive.rawValue


var sum = 0, n = 100;
sum = (1 + n) * n / 2;


var sum2 = 0;
for i in 0...n {
    sum2 += i;
}
sum2;
