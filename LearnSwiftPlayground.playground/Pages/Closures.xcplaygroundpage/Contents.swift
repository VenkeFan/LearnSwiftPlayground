//: [Previous](@previous)

import Foundation

// The Sorted Method

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2;
}

names.sorted(by: backward);

// Closure Expression Syntax

names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 < s2;
});

// Inferring Type From Context

names.sorted(by: { s1, s2 in
    return s1 > s2;
});

// Implicit Returns from Single-Expression Closures

names.sorted(by: { s1, s2 in s1 > s2});

// Shorthand Argument Names

names.sorted(by: { $0 > $1});

// Operator Methods

names.sorted(by: >);


// Trailing Closures

names.sorted() { (s1, s2) -> Bool in
    return s1 < s2;
};
names.sorted { (s1, s2) -> Bool in
    return s1 < s2;
};
names.sorted() { $0 > $1 };
names.sorted { $0 > $1 };


func someFunctionThatTakesAClosure(closure: () -> Void) {
    closure();
}
someFunctionThatTakesAClosure(closure: {
    print("Hello");
});
someFunctionThatTakesAClosure() {
    print("Hi");
};
someFunctionThatTakesAClosure { 
    print("Hey");
};


let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
];
let numbers = [16, 58, 510, 0];

let strings = numbers.map { (number) -> String in
    var number = number;
    var output = "";
    repeat {
        output = digitNames[number % 10]! + output;
        number /= 10;
    } while number > 0
    return output;
};
strings;



// Capturing Values

func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0;
    
    func incrementer() -> Int {
        runningTotal += amount;
        return runningTotal;
    }
    
    return incrementer;
}
let incrementByTen = makeIncrementer(forIncrement: 10);
incrementByTen();
incrementByTen();

let incrementByNine = makeIncrementer(forIncrement: 9);
incrementByNine();
incrementByNine();

let alsoIncrementByTen = incrementByTen;
alsoIncrementByTen();

var increment = makeIncrementer(forIncrement: 2);
increment();
increment();
increment = makeIncrementer(forIncrement: 3);
increment();


// Escaping Closures

var completionHandlers: [() -> Void] = [];
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler);
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure();
}


class SomeClass {
    var x = 10;
    
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100;
        };
        someFunctionWithNonescapingClosure { 
            x = 200;
        };
    }
}

let instance = SomeClass();
instance.doSomething();
instance.x;

completionHandlers.first!();
instance.x


// Autoclosures

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
customersInLine.count;

let customerProvider = { () -> String in return customersInLine.remove(at: 0) }; // { customersInLine.remove(at: 0) }
customersInLine.count;
customerProvider();
customersInLine.count;


func serve(customer customerProvider: () -> String) {
    customerProvider();
}
serve(customer: { customersInLine.remove(at: 0) });


func serve(customer customerProvider: @autoclosure () -> String) {
    customerProvider();
}
serve(customer: customersInLine.remove(at: 0));



var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider);
}
collectCustomerProviders(customersInLine.remove(at: 0));
collectCustomerProviders(customersInLine.remove(at: 0));

customerProviders.count;
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!");
}
customersInLine.count;
