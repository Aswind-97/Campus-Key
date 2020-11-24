//
//  ReviewDB.swift
//  CampusKey
//
//  Created by Nick Martinez on 11/23/20.
//

import Foundation
import SQLite3

/*Example:

//create class
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var color = ""
    @objc dynamic var age = 0
}

let realm = try! Realm()

//create dog object
var myDog = Dog()
myDog.name = "..."
myDog.color = "..."
myDog.age = ...

//add to database
try! realm.write{
    realm.add(myDog)
} */

class Student: Codable {
    var firstName : String?
    var lastName : String?
    var year : String?
    var major : String?
    var email : String?
    var id : Int?
}





//Example for Student:
//var student1 = Student()
//student1.firstName = "Zach"
//student1.lastName = "Muehler"
//student1.year = "Senior"
//student1.major = "Computer Science"
//student1.email = "zachary.muehler.668@my.csun.edu"
//student1.id = 000000000
//

class Professor: Codable {
    var name : String?
    var department : String?
    var rating : Int?
    var picture: Data? = nil // (May use)
}


class Food: Codable {
    var restaurantID : Int?
    var restaurant : String?
    var category : String?
    var rating : Int?
    var review : String?
    var picture : Data? = nil // (May use) // I think it's still 'data' for sqlite but its from realm for sure
}

//
////Example for Professor:
////var professor1 = Professor()
////professor1.name = "Mohammed Abdelrahim"
////professor1.department = "Computer Science"
////professor1.rating = 5
//
//class Department: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var rating = 0
//}
//
////Example for Department:
//var department1 = Department()
//department1.name = "Computer Science"
//department1.rating = 4
//
//class Class: Object {
//    @objc dynamic var department = ""
//    @objc dynamic var number = 0
//    @objc dynamic var description = ""
//    @objc dynamic var rating = 0
//}
//
////Example fpr Class:
//var class1 = Class()
//class1.department = "Computer Science"
//class1.number = 490
//class1.description = "Senior Design Project"
//class1.rating = 5
//
//class Location: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var category = ""
//    @objc dynamic var rating = 0
//    @objc dynamic var picture: Data? = nil //(May use)
//}
//
////Example for Location:
//var location1 = Location()
//location1.name = "Arbor Grill"
//location1.category = "Food"
//location1.rating = 4
//
//class Event: Object {
//    @objc dynamic var name = ""
//    @objc dynamic var date = ""
//    @objc dynamic var category = ""
//    @objc dynamic var location = ""
//    @objc dynamic var rating = 0 //May not need
//}
////Example for Event:
//var event1 = Event()
//event1.name = "The Big Show"
//event1.date = "10/03/2020"
//event1.category = "Entertainment"
//event1.location = "Oviatt Lawn"
//event1.rating = 4 //May not need
