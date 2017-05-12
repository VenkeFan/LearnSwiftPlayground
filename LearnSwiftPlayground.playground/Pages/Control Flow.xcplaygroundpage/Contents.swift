//: [Previous](@previous)

import Foundation

// For-In Loops

for index in 0...5 {
    print(index);
}

for index in 100..<105 {
    print(index);
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")


let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}


let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


// While Loops

let finalSquare = 25;
var board = [Int](repeating: 0, count: finalSquare + 1);
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0;
var diceRoll = 0;

while square < finalSquare {
    diceRoll += 1;
    if diceRoll >= 7 {
        diceRoll = 1;
    }
    square += diceRoll;
    
    if square < board.count {
        square += board[square];
    }
    print("Step: \(square)");
}
print("Game over!")


var max = 10;
var i = 10;
var j = 10;

while i < max {
    i += 1;
    print("while: \(j)");
}

repeat {
    j += 1;
    print("repeat while: \(j)");
} while j < max


// Switch

let letter = "a";
switch (letter) {
    case "a",
         "A":
        print("letter is A");
    default:
        print("letter is \(letter)");
}


let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")


let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("(0, 0) is at the origin")
    case (_, 0):
        print("(\(somePoint.0), 0) is on the x-axis")
    case (0, _):
        print("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
        print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    default:
        print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}


let anotherPoint = (2, 0)
switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}


let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
}


let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
    case "1", "١", "一", "๑":
        possibleIntegerValue = 1
    case "2", "٢", "二", "๒":
        possibleIntegerValue = 2
    case "3", "٣", "三", "๓":
        possibleIntegerValue = 3
    case "4", "٤", "四", "๔":
        possibleIntegerValue = 4
    default:
        break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}


let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    case 100:
        description += " haha ";
    default:
        description += " an integer."
}
print(description)


// Labeled Statements

square = 0;
diceRoll = 0;

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll >= 7 {
        diceRoll = 1
    }
    
    switch square + diceRoll {
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        continue gameLoop
    default:
        square += diceRoll
        square += board[square]
        print("Step: \(square)");
    }
}
print("Game over!")


// Early Exit

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        print(person)
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])
greet(person: ["location": "New York"]);


// Checking API Availability

if #available(iOS 10, macOS 10.12 , *) {
    
}
