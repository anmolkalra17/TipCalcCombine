//
//  Tip.swift
//  TipCalc
//
//  Created by Anmol Kalra on 04/11/23.
//

import Foundation

enum Tip {
	case none
	case tenPercent
	case fifteenPercent
	case twentyPercent
	case custom(value: Int)
	
	var stringValue: String {
		switch self {
		case .none:
			return ""
		case .tenPercent:
			return "10%"
		case .fifteenPercent:
			return "15%"
		case .twentyPercent:
			return "20%"
		case .custom(let value):
			return String(value)
		}
	}
}
