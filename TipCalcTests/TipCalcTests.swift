//
//  TipCalcTests.swift
//  TipCalcTests
//
//  Created by Anmol Kalra on 02/11/23.
//

import XCTest
import Combine
@testable import TipCalc

final class TipCalcTests: XCTestCase {
	
	//	sut -> System Under Test
	private var sut: CalculatorVM!
	private var cancellables: Set<AnyCancellable>!
	
	private let logoViewTapSubject = PassthroughSubject<Void, Never>()
	
	override func setUp() {
		super.setUp()
		sut = .init()
		cancellables = .init()
	}
	
	override func tearDown() {
		super.tearDown()
		sut = nil
		cancellables = nil
	}
	
	func testResultWithoutTipFor1Person() {
		//	given
		let bill = 100.0
		let tip = Tip.none
		let split = 1
		//	when
		let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
		//	then
		output.updateViewPublisher.sink { result in
			XCTAssertEqual(result.amountPerPerson, 100)
			XCTAssertEqual(result.totalBill, 100)
			XCTAssertEqual(result.totalTip, 0)
		}.store(in: &cancellables)
	}
	
	func testResultWithoutTipFor2People() {
		//	given
		let bill = 100.0
		let tip = Tip.none
		let split = 2
		//	when
		let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
		//	then
		output.updateViewPublisher.sink { result in
			XCTAssertEqual(result.amountPerPerson, 50)
			XCTAssertEqual(result.totalBill, 100)
			XCTAssertEqual(result.totalTip, 0)
		}.store(in: &cancellables)
	}
	
	func testResultWith10PercentTipFor2People() {
		//	given
		let bill = 100.0
		let tip = Tip.tenPercent
		let split = 2
		//	when
		let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
		//	then
		output.updateViewPublisher.sink { result in
			XCTAssertEqual(result.amountPerPerson, 55)
			XCTAssertEqual(result.totalBill, 110)
			XCTAssertEqual(result.totalTip, 10)
		}.store(in: &cancellables)
	}
	
	func testResultWithCustomTipFor4People() {
		//	given
		let bill = 200.0
		let tip = Tip.custom(value: 201)
		let split = 4
		//	when
		let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
		//	then
		output.updateViewPublisher.sink { result in
			XCTAssertEqual(result.amountPerPerson, 100.25)
			XCTAssertEqual(result.totalBill, 401)
			XCTAssertEqual(result.totalTip, 201)
		}.store(in: &cancellables)
	}
	
	private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
		return .init(billPublisher: Just(bill).eraseToAnyPublisher(),
					 tipPublisher: Just(tip).eraseToAnyPublisher(),
					 splitPublisher: Just(split).eraseToAnyPublisher(),
					 logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
	}
}
