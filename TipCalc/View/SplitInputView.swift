//
//  SplitInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Foundation
import UIKit

class SplitInputView: UIView {
	init() {
		super.init(frame: .zero)
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layout() {
		backgroundColor = .orange
	}
}
