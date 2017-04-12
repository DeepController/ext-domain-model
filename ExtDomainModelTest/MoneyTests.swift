//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import ExtDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
	
	let tenUSD = Money(amount: 10, currency: Money.CurrencyType.USD)
	let twelveUSD = Money(amount: 12, currency: Money.CurrencyType.USD)
	let fiveGBP = Money(amount: 5, currency: Money.CurrencyType.GBP)
	let fifteenEUR = Money(amount: 15, currency: Money.CurrencyType.EUR)
	let fifteenCAN = Money(amount: 15, currency: Money.CurrencyType.CAN)
	let zeroUSD = Money(amount: 0, currency: Money.CurrencyType.USD)
	let negativeUSD = Money(amount: -7, currency: Money.CurrencyType.USD)
	let millionUSD = Money(amount: 1000000, currency: Money.CurrencyType.USD)
	
	
	func testCanICreateMoney() {
		let oneUSD = Money(amount: 1, currency: Money.CurrencyType.USD)
		XCTAssert(oneUSD.amount == 1)
		XCTAssert(oneUSD.currency == Money.CurrencyType.USD)
		
		let tenGBP = Money(amount: 10, currency: Money.CurrencyType.GBP)
		XCTAssert(tenGBP.amount == 10)
		XCTAssert(tenGBP.currency == Money.CurrencyType.GBP)
	}
	
	func testUSDtoGBP() {
		let gbp = tenUSD.convert(Money.CurrencyType.GBP)
		XCTAssert(gbp.currency == Money.CurrencyType.GBP)
		XCTAssert(gbp.amount == 5)
	}
	func testUSDtoEUR() {
		let eur = tenUSD.convert(Money.CurrencyType.EUR)
		XCTAssert(eur.currency == Money.CurrencyType.EUR)
		XCTAssert(eur.amount == 15)
	}
	func testUSDtoCAN() {
		let can = twelveUSD.convert(Money.CurrencyType.CAN)
		XCTAssert(can.currency == Money.CurrencyType.CAN)
		XCTAssert(can.amount == 15)
	}
	func testGBPtoUSD() {
		let usd = fiveGBP.convert(Money.CurrencyType.USD)
		XCTAssert(usd.currency == Money.CurrencyType.USD)
		XCTAssert(usd.amount == 10)
	}
	func testEURtoUSD() {
		let usd = fifteenEUR.convert(Money.CurrencyType.USD)
		XCTAssert(usd.currency == Money.CurrencyType.USD)
		XCTAssert(usd.amount == 10)
	}
	func testCANtoUSD() {
		let usd = fifteenCAN.convert(Money.CurrencyType.USD)
		XCTAssert(usd.currency == Money.CurrencyType.USD)
		XCTAssert(usd.amount == 12)
	}
	
	func testUSDtoEURtoUSD() {
		let eur = tenUSD.convert(Money.CurrencyType.EUR)
		let usd = eur.convert(Money.CurrencyType.USD)
		XCTAssert(tenUSD.amount == usd.amount)
		XCTAssert(tenUSD.currency == usd.currency)
	}
	func testUSDtoGBPtoUSD() {
		let gbp = tenUSD.convert(Money.CurrencyType.GBP)
		let usd = gbp.convert(Money.CurrencyType.USD)
		XCTAssert(tenUSD.amount == usd.amount)
		XCTAssert(tenUSD.currency == usd.currency)
	}
	func testUSDtoCANtoUSD() {
		let can = twelveUSD.convert(Money.CurrencyType.CAN)
		let usd = can.convert(Money.CurrencyType.USD)
		XCTAssert(twelveUSD.amount == usd.amount)
		XCTAssert(twelveUSD.currency == usd.currency)
	}
	
	func testAddUSDtoUSD() {
		let total = tenUSD.add(tenUSD)
		XCTAssert(total.amount == 20)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testAddUSDtoUSDWithProtocol() {
		let total = tenUSD + tenUSD
		XCTAssert(total.amount == 20)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testAddNegativeUSD() {
		let total = tenUSD.add(negativeUSD)
		XCTAssert(total.amount == 3)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testAddNegativeUSDWithProtocol() {
		let total = tenUSD + negativeUSD
		XCTAssert(total.amount == 3)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testAddUSDtoGBP() {
		let total = tenUSD.add(fiveGBP)
		XCTAssert(total.amount == 10)
		XCTAssert(total.currency == Money.CurrencyType.GBP)
	}
	
	func testAddUSDtoGBPWithProtocol() {
		let total = tenUSD + fiveGBP
		XCTAssert(total.amount == 10)
		XCTAssert(total.currency == Money.CurrencyType.GBP)
	}
	
	func testSubtractUSDfromUSD() {
		let total = tenUSD.subtract(tenUSD)
		XCTAssert(total.amount == 0)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractUSDfromUSDWithProtocol() {
		let total = tenUSD - tenUSD
		XCTAssert(total.amount == 0)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractNegativeUSD() {
		let total = negativeUSD.subtract(tenUSD)
		XCTAssert(total.amount == 17)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractNegativeUSDWithProtocol() {
		let total = tenUSD - negativeUSD
		XCTAssert(total.amount == 17)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractFromZero() {
		let total = tenUSD.subtract(zeroUSD)
		XCTAssert(total.amount == -10)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractFromZeroWithProtocol() {
		let total = zeroUSD - tenUSD
		XCTAssert(total.amount == -10)
		XCTAssert(total.currency == Money.CurrencyType.USD)
	}
	
	func testSubtractUSDfromGBP() {
		let total = tenUSD.subtract(fiveGBP)
		XCTAssert(total.amount == 0)
		XCTAssert(total.currency == Money.CurrencyType.GBP)
	}
	
	func testSubtractUSDfromGBPWithProtocol() {
		let total = fiveGBP - tenUSD
		XCTAssert(total.amount == 0)
		XCTAssert(total.currency == Money.CurrencyType.GBP)
	}
	
	func testStringDescriptionOfMoney() {
		XCTAssert(tenUSD.description == "USD10.0")
		XCTAssert(fiveGBP.description == "GBP5.0")
		XCTAssert(twelveUSD.description == "USD12.0")
		XCTAssert(fifteenEUR.description == "EUR15.0")
		XCTAssert(fifteenCAN.description == "CAN15.0")
	}
	
	func testExtention() {
		let a = 0.1.USD
		let b =	0.1.GBP
		let c = 0.1.CAN
		let d = 0.1.EUR
		
		XCTAssert(a.amount == 0 && a.currency == Money.CurrencyType.USD)
		XCTAssert(b.amount == 0 && b.currency == Money.CurrencyType.GBP)
		XCTAssert(c.amount == 0 && c.currency == Money.CurrencyType.CAN)
		XCTAssert(d.amount == 0 && d.currency == Money.CurrencyType.EUR)
	}
}

