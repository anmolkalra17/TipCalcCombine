//
//  TipCalculatorSnapshotTests.swift
//  TipCalcTests
//
//  Created by Anmol Kalra on 17/11/23.
//

import SnapshotTesting
import XCTest
@testable import TipCalc

final class TipCalculatorSnapshotTests: XCTestCase {
	
	private var screenWidth: CGFloat {
		return UIScreen.main.bounds.width
	}
	
	func testLogoView() {
		//	given
		let size = CGSize(width: screenWidth, height: 48)
		//	when
		let view = LogoView()
		//	then
		assertSnapshot(matching: view, as: .image(size: size))
	}
	
	func testInitialResultView() {
		//	given
		let size = CGSize(width: screenWidth, height: 224)
		//	when
		let view = ResultView()
		//	then
		assertSnapshot(matching: view, as: .image(size: size))
	}
	
	func testInitialBillInputView() {
		//	given
		let size = CGSize(width: screenWidth, height: 56)
		//	when
		let view = BillInputView()
		//	then
		assertSnapshot(matching: view, as: .image(size: size))
	}
	
	func testInitialTipInputView() {
		//	given
		let size = CGSize(width: screenWidth, height: 56+56+16)
		//	when
		let view = TipInputView()
		//	then
		assertSnapshot(matching: view, as: .image(size: size))
	}
	
	func testSplitInputView() {
		//	given
		let size = CGSize(width: screenWidth, height: 56)
		//	when
		let view = SplitInputView()
		//	then
		assertSnapshot(matching: view, as: .image(size: size))
	}
}
