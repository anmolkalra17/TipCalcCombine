//
//  SplitInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Combine
import CombineCocoa
import UIKit

class SplitInputView: UIView {
	
	private let headerView: HeaderView = {
		return HeaderView(topText: "Split", bottomText: "the total")
	}()
	
	private lazy var decrementButton: UIButton = {
		let button = buildButton(text: "-", corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
		button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.decrementButton.rawValue
		button.tapPublisher.flatMap { [unowned self] _ in
			Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
		}.assign(to: \.value, on: splitSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var incrementButton: UIButton = {
		let button = buildButton(text: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
		button.accessibilityIdentifier = ScreenIdentifier.SplitInputView.incrementButton.rawValue
		button.tapPublisher.flatMap { [unowned self] _ in
			Just(splitSubject.value + 1)
		}.assign(to: \.value, on: splitSubject)
			.store(in: &cancellables)
		return button
	}()
	
	private lazy var quantityLabel: UILabel = {
		let label = LabelFactory.build(text: "1", font: ThemeFont.bold(of: 20))
		label.accessibilityIdentifier = ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue
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
	
	private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
	var valuePublisher: AnyPublisher<Int, Never> {
		return splitSubject.removeDuplicates().eraseToAnyPublisher()
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		super.init(frame: .zero)
		layout()
		observe()
	}
	
	func reset() {
		splitSubject.send(1)
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
	
	private func observe() {
		splitSubject.sink { [unowned self] quantity in
			quantityLabel.text = quantity.stringValue
		}.store(in: &cancellables)
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
