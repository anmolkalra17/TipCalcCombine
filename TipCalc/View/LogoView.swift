//
//  LogoView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Foundation
import UIKit

class LogoView: UIView {
	
	private let logoImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "icCalculatorBW"))
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let topLabel: UILabel = {
		let label = UILabel()
		
		let text = NSMutableAttributedString(string: "Mr TIP", attributes: [
			.font: ThemeFont.demiBold(of: 16),
			.foregroundColor: ThemeColor.textColor
		])
		text.addAttributes([
			.font: ThemeFont.bold(of: 24)
		], range: NSMakeRange(3, 3))
		label.attributedText = text
		
		return label
	}()
	
	private let bottomLabel: UILabel = {
		LabelFactory.build(text: "Calculator", font: ThemeFont.demiBold(of: 20), textAlignment: .left)
	}()
	
	private lazy var vStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
		view.axis = .vertical
		view.spacing = -4
		return view
	}()
	
	private lazy var hStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			logoImageView,
			vStackView
		])
		
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.alignment = .center
		
		return stackView
	}()
	
	init() {
		super.init(frame: .zero)
		accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func layout() {
		
		addSubview(hStackView)
		
		hStackView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.centerX.equalToSuperview()
		}
		
		logoImageView.snp.makeConstraints { make in
			make.height.equalTo(logoImageView.snp.width)
		}
	}
}
