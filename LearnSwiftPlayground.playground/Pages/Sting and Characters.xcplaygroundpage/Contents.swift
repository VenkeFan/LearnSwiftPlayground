//: Playground - noun: a place where people can play

import UIKit


var l1 = (1, 2, 3, 4, 5, 6)
var l2 = (1, 2, 3, 4, 5, 6)
l1 == l2


var a = Int("123");
var b = 1;
a ?? b;


let defaultColorName = "red";
var userDefinedColorName: String?;
var colorNameToUse = userDefinedColorName ?? defaultColorName;



var emptyStr = String();
emptyStr == "";
emptyStr.isEmpty


let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"];
let catString = String(catCharacters);


let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"


let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
eAcute == combinedEAcute

let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ

let enclosedEAcute: Character = "\u{E9}\u{20DD}"
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
print("the number of characters in \(word) is \(word.characters.count)")


// String Indices

let greeting = "Guten Tag!"
greeting.characters.count
for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: "")
}
print("\r")
greeting.startIndex
greeting.endIndex
greeting[greeting.startIndex]
greeting.index(before: greeting.endIndex)
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]


// Inserting and Removing

var welcome = "hello";
welcome += " world";
welcome.insert(contentsOf: "Hey, ".characters, at: welcome.startIndex);
welcome.insert("!", at: welcome.endIndex);

welcome.remove(at: welcome.index(after: welcome.startIndex));
welcome
welcome.removeSubrange(welcome.startIndex...welcome.index(welcome.startIndex, offsetBy: 3));
welcome.removeAll()


// Comparing Strings

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
quotation == sameQuotation

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
eAcuteQuestion == combinedEAcuteQuestion

let latinCapitalLetterA: Character = "\u{41}"           // "A" in English
let cyrillicCapitalLetterA: Character = "\u{0410}"      // "A" in Russian
latinCapitalLetterA == cyrillicCapitalLetterA


let dogString = "Dog‼🐶"
dogString.utf8
dogString.utf16
dogString.unicodeScalars

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("\r")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("\r")

for codeUnit in dogString.unicodeScalars {
    print("\(codeUnit) ", terminator: "")
}
print("\r")

for codeUnit in dogString.unicodeScalars {
    print("\(codeUnit.value) ", terminator: "")
}
print("\r")




