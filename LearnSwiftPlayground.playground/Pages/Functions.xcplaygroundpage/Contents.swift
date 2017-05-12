//: [Previous](@previous)

import Foundation

func greet(person: String) -> String {
    return "Hello, " + person + "!";
}
print(greet(person: "Anna"));


// Optional Tuple Return Types

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil;
    }
    
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)");
}


// Argument Labels and Parameter Names

// Specifying Argument Labels
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))

// Default Argument Labels
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    firstParameterName + secondParameterName;
}
someFunction(firstParameterName: 1, secondParameterName: 2)

// Omitting Argument Labels
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    firstParameterName + secondParameterName;
}
someFunction(1, secondParameterName: 2)


// Default Parameter Values

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    parameterWithoutDefault + parameterWithDefault
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)
someFunction(parameterWithoutDefault: 4)


// Variadic Parameters

func average(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
average(1, 2, 3, 4, 5)
average(3, 8.25, 18.75)


// In-Out Parameters

func swapTwoInts(_ a: inout Int, _ b: inout Int ) {
    let temp = a;
    a = b;
    b = temp;
}
var a = 1;
var b = 2;
swapTwoInts(&a, &b);
a;
b;


// Function Types

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts;
mathFunction(1, 2);

mathFunction = multiplyTwoInts;
mathFunction(1, 2);


// Function Types as Parameter Types

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))");
}
printMathResult(addTwoInts, 2, 3);
printMathResult(multiplyTwoInts, 2, 3);
printMathResult({ (a: Int, b: Int) -> Int in
    if b == 0 {
        return 0;
    }
    return a / b;
}, 4, 2);


// Function Types as Return Types

//func stepForward(_ input: Int) -> Int {
//    return input + 1
//}
//func stepBackward(_ input: Int) -> Int {
//    return input - 1
//}
//
//func chooseStepFunction(backward: Bool) -> (Int) -> Int {
//    return backward ? stepBackward : stepForward;
//}
//
//var currentValue = 3;
//let moveNearerToZero = chooseStepFunction(backward: currentValue > 0);
//print("Counting to zero:")
//while currentValue != 0 {
//    print("\(currentValue)... ")
//    currentValue = moveNearerToZero(currentValue)
//}
//print("zero!")


// Nested Functions

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    
    return backward ? stepBackward : stepForward;
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")



