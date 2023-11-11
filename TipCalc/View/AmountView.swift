//
//  AmountView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 04/11/23.
//

import UIKit

class AmountView: UIView {
	
	private let title: String
	private let textAlignment: NSTextAlignment
	
	private lazy var titleLabel: UILabel = {
		LabelFactory.build(text: title, font: ThemeFont.regular(of: 18), textColor: ThemeColor.textColor, textAlignment: textAlignment)
	}()
	
	private lazy var amountLabel: UILabel = {
		let label = UILabel()
		
		label.textAlignment = textAlignment
		label.textColor = ThemeColor.primary
		
		let text = NSMutableAttributedString(string: "$ 0", attributes: [
			.font: ThemeFont.bold(of: 24)
		])
		
		text.addAttributes([
			.font: ThemeFont.bold(of: 16)
		], range: NSMakeRange(0, 1))
		
		label.attributedText = text
		
		return label
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			titleLabel,
			amountLabel
		])
		
		stackView.axis = .vertical
		return stackView
	}()
	
	init(title: String, textAlignment: NSTextAlignment) {
		self.title = title
		self.textAlignment = textAlignment
		super.init(frame: .zero)
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layout() {
		addSubview(stackView)
		
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func configure(amount: Double) {
		let text = NSMutableAttributedString(string: amount.currencyFormatted, attributes: [
			.font: ThemeFont.bold(of: 24)
		])
		
		text.addAttributes([
			.font: ThemeFont.bold(of: 16)
		], range: NSMakeRange(0, 1))
		
		amountLabel.attributedText = text
	}
}
