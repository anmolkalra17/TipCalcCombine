//
//  HeaderView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 04/11/23.
//

import UIKit

class HeaderView: UIView {
	
	let topText: String
	let bottomText: String
	
	private lazy var topLabel: UILabel = {
		LabelFactory.build(text: topText, font: ThemeFont.bold(of: 18))
	}()
	
	private lazy var bottomLabel: UILabel = {
		LabelFactory.build(text: bottomText, font: ThemeFont.regular(of: 16))
	}()
	
	private let topSpacerView = UIView()
	private let bottomSpacerView = UIView()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			topSpacerView,
			topLabel,
			bottomLabel,
			bottomSpacerView
		])
		
		stackView.axis = .vertical
		stackView.alignment = .leading
		stackView.spacing = -4
		
		return stackView
	}()
	
	init(topText: String, bottomText: String) {
		self.topText = topText
		self.bottomText = bottomText
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
		
		topSpacerView.snp.makeConstraints { make in
			make.height.equalTo(bottomSpacerView)
		}
	}
}
