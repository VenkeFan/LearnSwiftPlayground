//: [Previous](@previous)

import Foundation


func addX(y: Int) -> ((Int) -> Int) {
    func addY(x: Int) -> Int {
        return x + y;
    }
    
    return addY;
}
var addY = addX(y: 3)(2);


// Literal Expression

func logFunctionName(str: String = #function) {
    print(str);
}

func myFunction() {
    logFunctionName();
}
myFunction();


// Capture Lists

var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
}
a = 10
b = 10
closure()

class SimpleClass {
    var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let referenceClosure = { [x] in
    print(x.value, y.value)
}
x.value = 10
y.value = 10
referenceClosure();


// Selector Expression

class SelectorClass: NSObject {
    let property: String
    
    @objc(doSomethingWithInt:)
    func doSomething(_ x: Int) {}
    
    init(property: String) {
        self.property = property
    }
}
//let selectorForMethod = #selector(SelectorClass.doSomething(_:));
let selectorForPropertyGetter = #selector(getter: SelectorClass.property)

extension SelectorClass {
    @objc(doSomethingWithString:)
    func doSomething(_ x: String) { }
}
let anotherSelector = #selector(SelectorClass.doSomething(_:) as (SelectorClass) -> (String) -> Void);


// Key-Path Expression

class KeyPathClass: NSObject {
    var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
    func keyPathTest() -> String {
        return #keyPath(someProperty)
    }
}
let c = KeyPathClass.init(someProperty: 12);
let keyPath = #keyPath(KeyPathClass.someProperty);
keyPath == c.keyPathTest();
c.value(forKey: keyPath);
c.value(forKey: "someProperty");


// Initializer Expression

let initializer: (Int) -> String = String.init;
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +);


// Explicit Member Expression

class SomeClass {
    func someMethod(x: Int, y: Int) {}
    func someMethod(x: Int, z: Int) {}
    func overloadedMethod(x: Int, y: Int) {}
    func overloadedMethod(x: Int, y: Bool) {}
}
let instance = SomeClass()

//let f = instance.someMethod              // Ambiguous
let f = instance.someMethod(x:y:)        // Unambiguous

//let f1 = instance.overloadedMethod        // Ambiguous
//let f1 = instance.overloadedMethod(x:y:)  // Still ambiguous
let f1: (Int, Bool) -> Void  = instance.overloadedMethod(x:y:)  // Unambiguous


// Postfix Self Expression

"123".self;

SomeClass.init();
SomeClass.self;
SomeClass.self.init();


// Dynamic Type Expression

class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}

let someInstance: SomeBaseClass = SomeSubClass();
type(of: someInstance).printClassName();


