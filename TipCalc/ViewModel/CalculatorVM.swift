//
//  CalculatorVM.swift
//  TipCalc
//
//  Created by Anmol Kalra on 04/11/23.
//

import Combine
import Foundation

class CalculatorVM {
	struct Input {
		let billPublisher: AnyPublisher<Double, Never>
		let tipPublisher: AnyPublisher<Tip, Never>
		let splitPublisher: AnyPublisher<Int, Never>
	}

	struct Output {
		let updateViewPublisher: AnyPublisher<CalcResult, Never>
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	func transform(input: Input) -> Output {
		
		input.tipPublisher.sink { tip in
			print("tip is: \(tip)")
		}.store(in: &cancellables)
		
		let result = CalcResult(amountPerPerson: 500, totalBill: 1000, totalTip: 20)
		return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
	}
}
