//
//  ThemeFont.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import UIKit

struct ThemeFont {
	static func regular(of size: CGFloat) -> UIFont {
		return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
	}
	
	static func bold(of size: CGFloat) -> UIFont {
		return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
	}
	
	static func demiBold(of size: CGFloat) -> UIFont {
		return UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
	}
}
