//
//  PersonTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class PersonTests: XCTestCase {

  func testPerson() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
	XCTAssert(ted.description == "Ted Neward aged 45")
  }
  
  func testAgeRestrictions() {
    let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)
	XCTAssert(matt.description == "Matthew Neward aged 15")
    
    matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    XCTAssert(matt.job == nil)

    matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
    XCTAssert(matt.spouse == nil)
  }
  
  func testAdultAgeRestrictions() {
    let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)
	XCTAssert(mike.description == "Michael Neward aged 22")
    
    mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    XCTAssert(mike.job != nil)
    
    mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
    XCTAssert(mike.spouse != nil)
  }
  
}

class FamilyTests : XCTestCase {
  
  func testFamily() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    
    let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
	XCTAssert(charlotte.description == "Charlotte Neward aged 45")
    
    let family = Family(spouse1: ted, spouse2: charlotte)

    let familyIncome = family.householdIncome()
    XCTAssert(familyIncome == 1000)
	XCTAssert(family.description == "A family with members: Ted Neward aged 45, Charlotte Neward aged 45")
  }
  
  func testFamilyWithKids() {
    let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
    ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    
    let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
    
    let family = Family(spouse1: ted, spouse2: charlotte)

    let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
    mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    
    let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
    let _ = family.haveChild(mike)
    let _ = family.haveChild(matt)
	
	XCTAssert(family.description == "A family with members: Ted Neward aged 45, Charlotte Neward aged 45, Mike Neward aged 22, Matt Neward aged 16")
    
    let familyIncome = family.householdIncome()
    XCTAssert(familyIncome == 12000)
  }
  
}
