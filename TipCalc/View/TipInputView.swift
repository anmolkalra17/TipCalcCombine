//
//  TipInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Combine
import CombineCocoa
import UIKit

class TipInputView: UIView {
	
	private let headerView: HeaderView = {
		return HeaderView(topText: "Choose", bottomText: "your tip")
	}()
	
	private lazy var tenPercentButton: UIButton = {
		let button = buildTipButton(tip: .tenPercent)
		button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPercentButton.rawValue
		button.tapPublisher.flatMap {
			Just(Tip.tenPercent)
		}.assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var fifteenPercentButton: UIButton = {
		let button = buildTipButton(tip: .fifteenPercent)
		button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
		button.tapPublisher.flatMap {
			Just(Tip.fifteenPercent)
		}.assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var twentyPercentButton: UIButton = {
		let button = buildTipButton(tip: .twentyPercent)
		button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
		button.tapPublisher.flatMap {
			Just(Tip.twentyPercent)
		}.assign(to: \.value, on: tipSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var customTipButton: UIButton = {
		let button = UIButton()
		button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
		button.setTitle("Custom Tip", for: .normal)
		button.titleLabel?.font = ThemeFont.bold(of: 20)
		button.backgroundColor = ThemeColor.primary
		button.tintColor = .white
		button.addCornerRadius(radius: 8.0)
		button.tapPublisher.sink { [weak self] _ in
			self?.handleCustomTipButton()
		}.store(in: &cancellables)
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
	
	//	A CurrentValueSubject can hold an initial value but a PassthroughSubject cannot
	//	Both can send and receive data
	private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
	var valuePublisher: AnyPublisher<Tip, Never> {
		return tipSubject.eraseToAnyPublisher()
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		super.init(frame: .zero)
		layout()
		observe()
	}
	
	func reset() {
		tipSubject.send(.none)
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
	
	private func handleCustomTipButton() {
		let alertContoller: UIAlertController = {
			let controller = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
			controller.addTextField { textField in
				textField.placeholder = "Make it generous..."
				textField.keyboardType = .numberPad
				textField.autocorrectionType = .no
				textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue
			}
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
			let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
				guard let text = controller.textFields?.first?.text, let value = Int(text) else { return }
				self?.tipSubject.send(.custom(value: value))
			}
			
			[okAction, cancelAction].forEach(controller.addAction(_:))
			return controller
		}()
		
		parentViewController?.present(alertContoller, animated: true)
	}
	
	private func observe() {
		tipSubject.sink { [unowned self] tip in
			resetView()
			
			switch tip {
			case .none:
				break
			case .tenPercent:
				tenPercentButton.backgroundColor = ThemeColor.secondary
			case .fifteenPercent:
				fifteenPercentButton.backgroundColor = ThemeColor.secondary
			case .twentyPercent:
				twentyPercentButton.backgroundColor = ThemeColor.secondary
			case .custom(let value):
				customTipButton.backgroundColor = ThemeColor.secondary
				
				let text = NSMutableAttributedString(string: "$\(value)", attributes: [
					.font: ThemeFont.bold(of: 20)
				])
				
				text.addAttributes([
					.font: ThemeFont.bold(of: 14)
				], range: NSMakeRange(0, 1))
				
				customTipButton.setAttributedTitle(text, for: .normal)
			}
		}.store(in: &cancellables)
	}
	
	private func resetView() {
		[tenPercentButton, fifteenPercentButton, twentyPercentButton, customTipButton].forEach {
			$0.backgroundColor = ThemeColor.primary
		}
		
		let text = NSMutableAttributedString(string: "Custom Tip", attributes: [
			.font: ThemeFont.bold(of: 20)
		])
		
		customTipButton.setAttributedTitle(text, for: .normal)
	}
	
	private func buildTipButton(tip: Tip) -> UIButton {
		let button = UIButton(type: .custom)
		button.backgroundColor = ThemeColor.primary
		button.tintColor = .white
		button.addCornerRadius(radius: 8.0)
		
		let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
			.font: ThemeFont.bold(of: 20),
			.foregroundColor: UIColor.white
		])
		
		text.addAttributes([
			.font: ThemeFont.demiBold(of: 14),
			.foregroundColor: UIColor.white
		], range: NSMakeRange(2, 1))
		
		button.setAttributedTitle(text, for: .normal)
		return button
	}
}
