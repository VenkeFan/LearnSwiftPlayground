//: [Previous](@previous)

import Foundation


// Customizing Initialization

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    // Initializer Parameters Without Argument Labels
    init(_ celsius: Double) {
        temperatureInCelsius = celsius;
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius;
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius;
let bodyTemperature = Celsius(37);
bodyTemperature.temperatureInCelsius;


// Parameter Names and Argument Labels

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color.init(red: 1, green: 0, blue: 1);
let halfGray = Color.init(white: 0.5);


// Optional Property Types

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
cheeseQuestion.text = "How about sweet?";
cheeseQuestion.ask();


// Assigning Constant Properties During Initialization

class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion2 = SurveyQuestion2(text: "How about beets?")
cheeseQuestion2.ask()
cheeseQuestion2.response = "I also like beets. (But not with cheese.)"


// Default Initializers

class ShoppingList {
    var name: String?
    var quantity = 1
    var purchased = false
}
ShoppingList();


// Memberwise Initializers for Structure Types

struct Size {
    var width = 0.0, height = 0.0
}
let size = Size.init(width: 2, height: 2);


// Initializer Delegation for Value Types

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point();
    var size = Size();
    init() {
        
    }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))


// Initializer Inheritance and Overriding

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init();
        numberOfWheels = 2;
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")


// Designated and Convenience Initializers in Action

class Food {
    var name: String;
    
    init(name: String) {
        self.name = name;
    }
    
    convenience init() {
        self.init(name: "[Unnamed]");
    }
}
Food.init(name: "Bacon").name;
Food.init().name;


class RecipeIngredient: Food {
    var quantity: Int;
    
    init(name: String, quantity: Int) {
        self.quantity = quantity;
        super.init(name: name);
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1);
    }
}
RecipeIngredient.init().quantity;
RecipeIngredient.init(name: "Eggs").quantity;
RecipeIngredient.init(name: "Eggs", quantity: 6).quantity;


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


// error: designated initializer for 'TestClass' cannot delegate (with 'self.init');
//class TestClass {
//    var width: Int;
//    var height: Int;
//
//    init(width: Int) {
//        self.init(width: width, height: 1);
//    }
//    
//    init(width: Int, height: Int) {
//        self.width = width;
//        self.height = height;
//    }
//}


// Failable Initializers

struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}


enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
TemperatureUnit.init(symbol: "K");
TemperatureUnit.init(symbol: "X");


// Failable Initializers for Enumerations with Raw Values

enum Number: Int {
    case one = 1
    case two
    case three
}
Number.init(rawValue: 3);
Number.init(rawValue: 0);


// Propagation of Initialization Failure

class Product {
    let name: String;
    
    init?(name: String) {
        if name.isEmpty {
            return nil;
        }
        self.name = name;
    }
}

class CartItem: Product {
    let quantity: Int;
    
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil;
        }
        
        self.quantity = quantity;
        super.init(name: name);
    }
    
    override init?(name: String) {
        self.quantity = 1;
        super.init(name: name);
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 1) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
} else {
    print("Unable to initialize")
}


// Overriding a Failable Initializer

class Document {
    var name: String?;
    
    init() {
        
    }
    
    init?(name: String) {
        if name.isEmpty {
            return nil;
        }
        self.name = name;
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init();
        self.name = "[Untitled]";
    }
    
    override init(name: String) {
        super.init();
        
        if name.isEmpty {
            self.name = "[Untitled]";
        } else {
            self.name = name;
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!;
    }
}


// Required Initializers

class SomeClass {
    required init() {
        
    }
}

class SomeSubClass: SomeClass {
    required init() {
        
    }
}

class SomeSubClass2: SomeClass {
    
}


// Setting a Default Property Value with a Closure or Function

struct Chessboard {
    let boardColors: [Bool] = {
        var tempBoard = [Bool]();
        var isBlack = false;
        for i in 1...8 {
            for j in 1...8 {
                tempBoard.append(isBlack);
                isBlack = !isBlack;
            }
            isBlack = !isBlack;
        }
        
        return tempBoard;
    }();
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column];
    }
}

var board = Chessboard.init();
board.squareIsBlackAt(row: 0, column: 1);



