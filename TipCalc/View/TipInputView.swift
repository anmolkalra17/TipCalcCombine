//
//  TipInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Foundation
import UIKit

class TipInputView: UIView {
	
	private let headerView: HeaderView = {
		return HeaderView(topText: "Choose", bottomText: "your tip")
	}()
	
	private lazy var tenPercentButton: UIButton = {
		let button = buildTipButton(tip: .tenPercent)
		return button
	}()
	
	private lazy var fifteenPercentButton: UIButton = {
		let button = buildTipButton(tip: .fifteenPercent)
		return button
	}()
	
	private lazy var twentyPercentButton: UIButton = {
		let button = buildTipButton(tip: .twentyPercent)
		return button
	}()
	
	private lazy var customTipButton: UIButton = {
		let button = UIButton()
		button.setTitle("Custom Tip", for: .normal)
		button.titleLabel?.font = ThemeFont.bold(of: 20)
		button.backgroundColor = ThemeColor.primary
		button.tintColor = .white
		button.addCornerRadius(radius: 8.0)
		return button
	}()
	
	private lazy var hStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			tenPercentButton,
			fifteenPercentButton,
			twentyPercentButton
		])
		
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 16
		
		return stackView
	}()
	
	private lazy var buttonVStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			hStackView,
			customTipButton
		])
		
		stackView.axis = .vertical
		stackView.spacing = 16
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	init() {
		super.init(frame: .zero)
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layout() {
		[headerView, buttonVStackView].forEach(addSubview(_:))
		
		buttonVStackView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview()
		}
		
		headerView.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
			make.width.equalTo(68)
			make.centerY.equalTo(hStackView.snp.centerY)
		}
	}
	
	private func buildTipButton(tip: Tip) -> UIButton {
		let button = UIButton(type: .custom)
		button.backgroundColor = ThemeColor.primary
		button.tintColor = .white
		button.addCornerRadius(radius: 8.0)
		
		let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
			.font: ThemeFont.bold(of: 20)
		])
		
		text.addAttributes([
			.font: ThemeFont.demiBold(of: 14)
		], range: NSMakeRange(2, 1))
		
		button.setAttributedTitle(text, for: .normal)
		return button
	}
}
