//
//  Double+Extension.swift
//  TipCalc
//
//  Created by Anmol Kalra on 11/11/23.
//

import Foundation

extension Double {
	var currencyFormatted: String {
		var isWholeNumber: Bool {
			isZero ? true : !isNormal ? false : self == rounded()
		}
		
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencyCode = "USD"
		formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
		return formatter.string(for: self) ?? ""
	}
}
