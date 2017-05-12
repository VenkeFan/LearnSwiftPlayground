//: [Previous](@previous)

import Foundation

// Definition Syntax

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution();
let someVideoMode = VideoMode();
someVideoMode.resolution.width = 1280;
someVideoMode.resolution.width


// Memberwise Initializers for Structure Types

var vga = Resolution.init(width: 640, height: 480);
print("\(vga.width)x\(vga.height)");

vga = Resolution(width: 1280, height: 960);
print("\(vga.width)x\(vga.height)");


// Structures and Enumerations Are Value Types

let hd = Resolution.init(width: 1920, height: 1080);
var cinema = hd;
hd.width;
cinema.width;

cinema.width = 2048;
hd.width;
cinema.width;


enum CompassPoint {
    case north, south, east, west
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east
rememberedDirection


// Classes Are Reference Types

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

tenEighty.frameRate;


// Identity Operators

tenEighty === alsoTenEighty;


