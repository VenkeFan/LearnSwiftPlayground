//: [Previous](@previous)

import Foundation

// Enumeration Syntax

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west;
directionToHead = .east;


// Matching Enumeration Values with a Switch Statement

directionToHead = .south;
switch directionToHead {
case .north:
    print("Lots of planets have a north");
case .south:
     print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}


// Associated Values

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3);
productBarcode = .qrCode("ABCDEFGHIJKLMNOP");

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).");
case .qrCode(let productCode):
    print("QR code: \(productCode)");
}

switch productBarcode {
case var .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).");
case let .qrCode(productCode):
    print("QR code: \(productCode)");
}

enum Number {
    case integer(Int)
    case real(Double)
}
var f = Number.integer;
let evenInts: [Number] = [0, 2, 4, 6].map(f)


// Raw Values

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


// Implicitly Assigned Raw Values

enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
Planet2.earth.rawValue

enum CompassPoint2: String {
    case north, south, east, west
}
CompassPoint2.east.rawValue


enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
Rank.king;
Rank.king.rawValue;
Rank.king.simpleDescription();


// Initializing from a Raw Value

let possiblePlanet = Planet2(rawValue: 7);

let positionToFind = 11;
if let somePlanet = Planet2.init(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
     print("There isn't a planet at position \(positionToFind)")
}


// Recursive Enumerations

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// (5 + 4) * 2
let five = ArithmeticExpression.number(5);
let four = ArithmeticExpression.number(4);
let sum = ArithmeticExpression.addition(five, four);
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2));

func evalute(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value;
    case let .addition(i1, i2):
        return evalute(i1) + evalute(i2);
    case let .multiplication(i1, i2):
        return evalute(i1) * evalute(i2);
    }
}

evalute(product);


