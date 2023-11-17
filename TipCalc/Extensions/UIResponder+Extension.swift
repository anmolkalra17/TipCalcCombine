//
//  UIResponder+Extension.swift
//  TipCalc
//
//  Created by Anmol Kalra on 05/11/23.
//

import UIKit

extension UIResponder {
	var parentViewController: UIViewController? {
		return next as? UIViewController ?? next?.parentViewController
	}
}
