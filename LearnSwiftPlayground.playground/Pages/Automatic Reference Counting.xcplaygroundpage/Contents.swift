//: [Previous](@previous)

import Foundation


// ARC in Action

/*

class Person {
    let name: String;
    
    init(name: String) {
        self.name = name;
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person.init(name: "John Appleseed");
reference2 = reference1;
reference3 = reference1;

reference1 = nil;
reference2 = nil;

reference3 = nil;

*/


// Strong Reference Cycles Between Class Instances

/*

class Person {
    let name: String;
    var apartment: Apartment?;
    
    init(name: String) {
        self.name = name;
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String;
    
    // Resolving Strong Reference Cycles Between Class Instances
    weak var tenant: Person?; // Weak References
    
    init(unit: String) {
        self.unit = unit;
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?;
var unit4A: Apartment?;

john = Person.init(name: "John Appleseed");
unit4A = Apartment.init(unit: "4A");

john?.apartment = unit4A;
unit4A?.tenant = john;

john = nil;
unit4A = nil;

*/


// Unowned References

/*
 
class Customer {
    let name: String;
    var card: CreditCard?;
    
    init(name: String) {
        self.name = name;
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64;
    unowned let customer: Customer;
    
    init(number: UInt64, customer: Customer) {
        self.number = number;
        self.customer = customer;
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var john: Customer?;
john = Customer(name: "John Appleseed");
john?.card = CreditCard.init(number: 1234_5678_9012_3456, customer: john!);

john = nil;

*/


// Unowned References and Implicitly Unwrapped Optional Properties

class Country {
    let name: String;
    var capitalCity: City!;
    
    init(name: String, capitalName: String) {
        self.name = name;
        self.capitalCity = City.init(name: capitalName, country: self);
    }
    
    deinit {
        print("Country \(name) is being deinitialized");
    }
}

class City {
    let name: String;
    unowned let country: Country;
    
    init(name: String, country: Country) {
        self.name = name;
        self.country = country;
    }
    
    deinit {
        print("City \(name) is being deinitialized");
    }
}

var country = Country.init(name: "China", capitalName: "Beijing");
print("\(country.name)'s capital city is called \(country.capitalCity.name)")


// Strong Reference Cycles for Closures

class HTMLElement {
    let name: String;
    let text: String?;
    
    lazy var asHTML: () -> String = {
        [unowned self] in // Resolving Strong Reference Cycles for Closures
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>";
        } else {
            return "<\(self.name) />";
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name;
        self.text = text;
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

/*
 
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
heading.asHTML();
 
*/

var paragraph: HTMLElement? = HTMLElement.init(name: "p", text: "hello world");
paragraph?.asHTML();
paragraph = nil;






