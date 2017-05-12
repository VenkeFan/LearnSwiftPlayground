//: [Previous](@previous)

import Foundation


// Instance Methods

class Counter {
    var count = 0;
    
    func increment() -> () {
        count += 1;
    }
    
    func increment(by amount: Int) -> () {
        count += amount;
    }
    
    func reset() {
        count = 0;
    }
}
let counter = Counter.init();
counter.increment();
counter.count;
counter.increment(by: 5);
counter.count;
counter.reset();
counter.count;


// The self Property

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
somePoint.isToTheRightOf(x: 1.0)


// Modifying Value Types from Within Instance Methods

struct Point2 {
    var x = 0.0, y = 0.0;
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX;
        y += deltaY;
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

let fixPoint = Point2(x: 3, y: 3);
//fixPoint.moveBy(x: 2, y: 3); // error


// Assigning to self Within a Mutating Method

struct Point3 {
    var x = 0.0, y = 0.0;
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY);
    }
}

enum TriStateSwitch{
    case off, low, high;
    
    mutating func next() {
        switch self {
        case .off:
            self = .low;
        case .low:
            self = .high;
        case .high:
            self = .off;
        }
    }
}
var ovenLight = TriStateSwitch.low;
ovenLight.next();
ovenLight.next();


// Type Methods

class SomeClass {
    static func someTypeMethod() {
        print("static func");
    }
    
    class func someTypeMethod2() {
        print("class func");
    }
}
SomeClass.someTypeMethod();
SomeClass.someTypeMethod2();


struct LevelTracker {
    static var highestUnlockedLevel = 1;
    var currentLevel = 1;
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level;
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel;
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level;
            return true;
        } else {
            return false;
        }
    }
}

class Player {
    var tracker = LevelTracker();
    let playerName: String;
    
    init(name: String) {
        playerName = name;
    }
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1);
        tracker.advance(to: level + 1);
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto");
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}


