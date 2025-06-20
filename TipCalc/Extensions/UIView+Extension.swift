//
//  UIView+Extension.swift
//  TipCalc
//
//  Created by Anmol Kalra on 04/11/23.
//

import UIKit

extension UIView {
	func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
		layer.cornerRadius = radius
		layer.masksToBounds = false
		layer.shadowOffset = offset
		layer.shadowColor = color.cgColor
		layer.shadowRadius = radius
		layer.shadowOpacity = opacity
		
		let backgrounfCGColor = backgroundColor?.cgColor
		backgroundColor = nil
		layer.backgroundColor = backgrounfCGColor
	}
	
	func addCornerRadius(radius: CGFloat) {
		layer.masksToBounds = false
		layer.cornerRadius = radius
	}
	
	func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
		layer.cornerRadius = radius
		layer.maskedCorners = [corners]
	}
}
