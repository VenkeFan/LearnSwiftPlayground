//: [Previous](@previous)

import Foundation


// Custom Types

public class SomePublicClass {                   // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                        // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {         // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                 // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}


// Function Types

//func someFunction() -> (SomeInternalClass, SomePrivateClass) {      // error
//    return (SomeInternalClass.init(), SomePrivateClass.init());
//}

private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass.init(), SomePrivateClass.init());
}


// Subclassing

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod();
    }
}

class C : B {
    
}


// Constants, Variables, Properties, and Subscripts

private var privateInstance = SomePrivateClass.init();


// Getters and Setters

struct TrackedString {
    private(set) var numberOfEdits = 0;
    var value: String = "" {
        didSet {
            numberOfEdits += 1;
        }
    }
}

var stringToEdit = TrackedString();
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

//extension TrackedString {
//    func test() -> Void {
//        numberOfEdits = 10; // error
//    }
//}

public struct TrackedString2 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}


