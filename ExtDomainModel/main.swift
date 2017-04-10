//
//  main.swift
//  SimpleDomainModel
//
//  Created by Yang Wang on 4/10/16.
//  Copyright © 2016 Yang Wang. All rights reserved.
//

import Foundation

////////////////////////////////////
// Protocol
//

protocol CustomStringConvertible {
	var description : String { get }
}

protocol Mathematics {
	static func +(left : Self, right : Self) -> Self
	static func -(left : Self, right : Self) -> Self
}

extension Double {
	var USD: Money { return Money(amount: Int(self), currency: Money.CurrencyType.USD) }
	var EUR: Money { return Money(amount: Int(self), currency: Money.CurrencyType.EUR) }
	var GBP: Money { return Money(amount: Int(self), currency: Money.CurrencyType.GBP) }
	var YEN: Money { return Money(amount: Int(self), currency: Money.CurrencyType.YEN) }
}

public func testMe() -> String {
	return "I have been tested"
}

open class TestMe {
	open func Please() -> String {
		return "I have been tested"
	}
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
	public var amount : Int
	public var currency : CurrencyType
	internal var description: String { get {return "\(currency)\(amount).00"}}
	
	public enum CurrencyType {
		case USD
		case GBP
		case EUR
		case CAN
		case YEN
	}
	
	public func convert(_ to: CurrencyType) -> Money {
		
		var temp = Money(amount: self.amount, currency: to)
		
		switch currency {
		case .GBP:
			temp.amount *= 2
		case .EUR:
			temp.amount = temp.amount / 3 * 2
		case .CAN:
			temp.amount = temp.amount / 5 * 4
		default:
			break
		}
		
		switch to {
		case .GBP:
			temp.amount /= 2
			return temp
		case .EUR:
			temp.amount = temp.amount / 2 * 3
			return temp
		case .CAN:
			temp.amount = temp.amount / 4 * 5
			return temp
		case .USD:
			return temp
		default:
			return temp
		}
	}
	
	public func add(_ to: Money) -> Money {
		let temp = self.convert(to.currency)
		return Money(amount: to.amount + temp.amount, currency: to.currency)
	}
	
	public func subtract(_ from: Money) -> Money {
		let temp = self.convert(self.currency)
		return Money(amount: from.amount - temp.amount, currency: from.currency)
	}
	
	static func +(left : Money, right : Money) -> Money {
		return left.add(right)
	}
	
	static func -(left : Money, right : Money) -> Money {
		return left.add(right)
	}
}

//////////////////////////////////
// Job
//

open class Job : CustomStringConvertible {
	fileprivate var title : String
	fileprivate var type : JobType
	internal var description: String { get {return "a \(type) with title \(title)"}}
	
	public enum JobType {
		case Hourly(Double)
		case Salary(Int)
		
		func get() -> Double {
			switch self {
			case .Hourly(let num):
				return num
			case .Salary(let num):
				return Double(num)
			}
		}
	}
	
	public init(title : String, type : JobType) {
		self.title = title
		self.type = type
	}
	
	open func calculateIncome(_ hours: Int) -> Int {
		switch type {
		case .Salary(let num):
			return num
		case .Hourly(let rate):
			return Int(rate * Double(hours))
		}
	}
	
	open func raise(_ amt : Double) {
		switch type {
		case .Hourly(let num):
			self.type = JobType.Hourly(num + amt)
		case .Salary(let num):
			self.type = JobType.Salary(num + Int(amt))
		}
	}
}



////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible {
	open var firstName : String = ""
	open var lastName : String = ""
	open var age : Int = 0
	internal var description: String {get {return "\(firstName)\(lastName) aged \(age)"}}
	
	fileprivate var _job : Job? = nil
	open var job : Job? {
		get { return _job }
		set(value) {
			if self.age >= 16 {
				_job = value
			} else {
				_job = nil
			}
		}
	}
	
	fileprivate var _spouse : Person? = nil
	open var spouse : Person? {
		get { return _spouse }
		set(value) {
			if self.age >= 18 {
				_spouse = value
			} else {
				_spouse = nil
			}
		}
	}
	
	public init(firstName : String, lastName: String, age : Int) {
		self.firstName = firstName
		self.lastName = lastName
		self.age = age
	}
	
	open func toString() -> String {
		return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self._job)) spouse:\(String(describing: self._spouse))]"
	}
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible{
	fileprivate var members : [Person] = []
	
	internal var description: String {
		get {
			var str = ""
			for p in members {
				str += p.description + ", "
			}
			return "A family with members: \(str)"
		}
	}
	
	public init(spouse1: Person, spouse2: Person) {
		guard spouse1.spouse == nil && spouse2.spouse == nil else {
			return
		}
		spouse1.spouse = spouse2
		spouse2.spouse = spouse1
		self.members = [spouse1, spouse2]
	}
	
	open func haveChild(_ child: Person) -> Bool {
		for p in members {
			if p.age >= 21 {
				self.members.append(child)
				return true
			}
		}
		return false
	}
	
	open func householdIncome() -> Int {
		var sum : Int = 0
		for p in members {
			guard p.job != nil else { continue }
			sum += p.job!.calculateIncome(2000)
		}
		return sum
	}
}




























