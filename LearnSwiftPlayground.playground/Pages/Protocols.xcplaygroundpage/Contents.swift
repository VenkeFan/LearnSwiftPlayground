//: [Previous](@previous)

import Foundation


// Property Requirements

protocol FullyNamed {
    var fullName: String { get }
}


struct Person: FullyNamed {
    var fullName: String;
}
let john = Person.init(fullName: "john");


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name;
    }
    
    init(name: String, prefix: String? = nil) {
        self.name = name;
        self.prefix = prefix;
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS");
ncc1701.fullName;


// Method Requirements

protocol RandomNumberGenerator {
    func random() -> Double;
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m);
        return lastRandom / m;
    }
}
let generator = LinearCongruentialGenerator();
generator.random();
generator.random();


// Mutating Method Requirements

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on;
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on;
        case .on:
            self = .off;
        }
    }
}
var lightSwitch = OnOffSwitch.off;
lightSwitch.toggle();


// Initializer Requirements

protocol SomeProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        
    }
}

final class SomeClass2: SomeProtocol {
    init(someParameter: Int) {
        
    }
}

struct SomeStruct: SomeProtocol {
    init(someParameter: Int) {
        
    }
}


protocol SomeProtocol2 {
    init()
}

class SomeSuperClass {
    init() {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol2 {
    // "required" from SomeProtocol2 conformance; "override" from SomeSuperClass
    required override init() {
        
    }
}


// Protocols as Types

class Dice {
    let sides: Int;
    let generator: RandomNumberGenerator;
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides;
        self.generator = generator;
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1;
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


// Delegation

protocol DiceGame {
    var dice: Dice { get };
    func play();
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame);
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int);
    func gameDidEnd(_ game: DiceGame);
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    var square = 0
    var board: [Int]
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var delegate: DiceGameDelegate?
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    func play() {
        square = 0;
        delegate?.gameDidStart(self);
        
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll();
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll);
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop;
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self);
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


// Adding Protocol Conformance with an Extension

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
d12.textualDescription;

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
game.textualDescription;


// Declaring Protocol Adoption with an Extension

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
somethingTextRepresentable.textualDescription


// Collections of Protocol Types

let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}


// Protocol Inheritance

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription);


// Class-Only Protocols

/*
protocol SomeClassOnlyProtocol: class {
    
}

class TestSomeClass: SomeClassOnlyProtocol {

}

struct TestSomeStruct: SomeClassOnlyProtocol {
    
}

enum TestSomeEnum: SomeClassOnlyProtocol {
    
}
*/


// Protocol Composition

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Human: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Human(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)


// Checking for Protocol Conformance

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}


// Optional Protocol Requirements

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int;
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter.init();
counter.dataSource = ThreeSource.init();
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

///////// error: non-class type 'TestStruct' cannot conform to class protocol 'CounterDataSource'
// struct TestStruct: CounterDataSource {
//
// }

// Protocol Extensions

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5;
    }
}

generator.random();
generator.randomBool();


// Providing Default Implementations

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription;
    }
}


// Adding Constraints to Protocol Extensions

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
hamsters.textualDescription


