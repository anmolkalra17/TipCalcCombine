//
//  SplitInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Foundation
import UIKit

class SplitInputView: UIView {
	
	private let headerView: HeaderView = {
		return HeaderView(topText: "Split", bottomText: "the total")
	}()
	
	private lazy var decrementButton: UIButton = {
		let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
		return button
	}()
	
	private lazy var incrementButton: UIButton = {
		let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
		return button
	}()
	
	private lazy var quantityLabel: UILabel = {
		let label = LabelFactory.build(text: "1", font: ThemeFont.bold(of: 20))
		label.backgroundColor = .white
		return label
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			decrementButton,
			quantityLabel,
			incrementButton
		])
		
		stackView.axis = .horizontal
		stackView.spacing = 0
		
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
		[headerView, stackView].forEach(addSubview(_:))
		
		stackView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview()
		}
		
		[incrementButton, decrementButton].forEach { button in
			button.snp.makeConstraints { make in
				make.width.equalTo(button.snp.height)
			}
		}
		
		headerView.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.centerY.equalTo(stackView.snp.centerY)
			make.trailing.equalTo(stackView.snp.leading).offset(-24)
			make.width.equalTo(68)
		}
	}
	
	private func buildButton(text: String, corners: CACornerMask) -> UIButton {
		let button = UIButton()
		button.setTitle(text, for: .normal)
		button.titleLabel?.font = ThemeFont.bold(of: 20)
		button.addRoundedCorners(corners: corners, radius: 8.0)
		button.backgroundColor = ThemeColor.primary
		return button
	}
}
