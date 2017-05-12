//: [Previous](@previous)

import Foundation

// Array

var array1 = Array.init(["a", "abc", 10, 100]);
var array2 = Array<Int>();
var array3 = Array<Int>.init();
var someInts = [Int]();
var otherInts : [Int] = [];
someInts.append(contentsOf: [1, 2]);
someInts.append(contentsOf: [2, 3]);
someInts = [];

var threeDoubles = Array.init(repeating: 0.0, count: 3);
var anotherDoubles = Array.init(repeating: 2.5, count: 4);
var doubles = threeDoubles + anotherDoubles;

var shoppingList = ["Eggs", "Milk"];
shoppingList.isEmpty;
shoppingList.append("Flour");
shoppingList += ["Breads"];
var firstItem = shoppingList[0];
shoppingList[0] = "Six eggs";
shoppingList;
shoppingList[2...3];
shoppingList[2...3] = ["Bananas"];
shoppingList;
shoppingList.insert("Apples", at: 0);
shoppingList.remove(at: 1);
shoppingList[1];

for item in shoppingList {
    print(item);
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index): \(value)");
}
print("\n")

// NSArray

var mutableArray = NSMutableArray.init();
mutableArray.add("x");
mutableArray.add(1);

var array = NSArray.init(objects: "a", 1);
var newArray = array.adding("b");
newArray.append("c");
newArray.append(2)


// Sets

var letters = Set<Character>();
letters.count;
letters.insert("a");

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"];
favoriteGenres.isEmpty;

var result = favoriteGenres.insert("Jazz");
result.inserted;
result.memberAfterInsert;

if let removeItem = favoriteGenres.remove("Rock") {
    print(removeItem);
    print("\r")
}

favoriteGenres.contains("Rock");

for genre in favoriteGenres {
    print(genre);
}
print("\r")
for genre in favoriteGenres.sorted() {
    print(genre);
}
print("\r")
for (index, value) in favoriteGenres.enumerated() {
    print("Genre \(index): \(value)");
}
print("\r")

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sorted();
oddDigits.intersection(evenDigits).sorted();
oddDigits.subtracting(singleDigitPrimeNumbers).sorted();
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted();

let houseAnimals: Set = ["🐶", "🐱"];
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"];
let cityAnimals: Set = ["🐦", "🐭"];
houseAnimals.isSubset(of: farmAnimals);
farmAnimals.isSuperset(of: houseAnimals);
farmAnimals.isDisjoint(with: cityAnimals);


// Dictionaries

var namesOfIntegers = [Int: String]();
namesOfIntegers.isEmpty;
namesOfIntegers[16] = "sixteen";
namesOfIntegers = [:];

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"];
var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"];
airports["LHR"] = "London"; // add
airports
airports["LHR"] = "London Heathrow"; // change
airports


let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB");
airports;

airports["APL"] = "Apple International";
airports;
airports["APL"] = nil;
airports;
airports.removeValue(forKey: "LHR");
airports;

for item in airports {
    print(item.key + ": " + item.value);
}
print("\r");
