//: [Previous](@previous)

import Foundation


// Stored Properties

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange.init(firstValue: 0, length: 3);
rangeOfThreeItems.firstValue = 6;
//rangeOfThreeItems.length = 4; // error

let rangeOfFourItems = FixedLengthRange.init(firstValue: 0, length: 4);
//rangeOfFourItems.firstValue = 6; // error


// Lazy Stored Properties

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")


// Computed Properties

struct Point {
    var x = 0.0, y = 0.0;
}

struct Size {
    var width = 0.0, height = 0.0;
}

struct Rect {
    var origin = Point();
    var size = Size();
    
    var center: Point {
        get {
            let centerX = origin.x + size.width * 0.5;
            let centerY = origin.y + size.height * 0.5;
            return Point.init(x: centerX, y: centerY);
        }
        set {
            origin.x = newValue.x - size.width * 0.5;
            origin.y = newValue.y - size.height * 0.5;
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0));
let initialSquareCenter = square.center;
square.center = Point(x: 15.0, y: 15.0);
square.origin.x;
square.origin.y


// Read-Only Computed Properties

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0;
    var volume: Double {
        return width * height * depth;
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0);
fourByFiveByTwo.volume;


// Property Observers

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter();
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896


class TestClass {
    var property: Int {
        willSet {
            
        }
        didSet {
            property = 2;
        }
    }
    
    init() {
        property = 0;
    }
}
var test = TestClass.init();
test.property;
test.property = 1;
test.property;


// Type Properties

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
    
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
class SubSomeClass: SomeClass {
    // error
//    override static var computedTypeProperty: Int {
//        return 28;
//    }
    
    override class var overrideableComputedTypeProperty: Int {
        return 108;
    }
}


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)


