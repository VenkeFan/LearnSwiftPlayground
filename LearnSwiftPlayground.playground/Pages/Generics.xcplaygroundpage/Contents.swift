//: [Previous](@previous)

import Foundation


// The Problem That Generics Solve

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a;
    a = b;
    b = temporaryA;
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}


// Generic Functions

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a;
    a = b;
    b = temporaryA;
}

swapTwoValues(&someInt, &anotherInt);
someInt;
anotherInt;

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
someString;
anotherString;


// Generic Types

struct Stack<Element> {
    var items = [Element]();
    
    mutating func push(_ item: Element) {
        items.append(item);
    }
    mutating func pop() -> Element {
        return items.removeLast();
    }
}

var stackOfStrings = Stack<String>.init();
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
stackOfStrings.items;

let fromTheTop = stackOfStrings.pop();
stackOfStrings.items;


// Extending a Generic Type

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1];
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}


// Type Constraints

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index;
        }
    }
    return nil;
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])


// Associated Types

protocol Container {
    associatedtype ItemType;
    
    mutating func append(_ item: ItemType);
    var count: Int { get };
    subscript(i: Int) -> ItemType { get };
}

struct AssociatedStack<Element>: Container {
    var items = [Element]();
    
    mutating func push(_ item: Element) {
        items.append(item);
    }
    mutating func pop() -> Element {
        return items.removeLast();
    }
    
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item);
    }
    
    var count: Int {
        return self.items.count;
    }
    
    subscript(i: Int) -> Element {
        return self.items[i];
    }
}


// Extending an Existing Type to Specify an Associated Type

extension Array: Container {}


// Generic Where Clauses

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        
        if someContainer.count != anotherContainer.count {
            return false;
        }
        
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false;
            }
        }
        
        return true;
}

var strings = AssociatedStack<String>()
strings.push("uno")
strings.push("dos")
strings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(strings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}


