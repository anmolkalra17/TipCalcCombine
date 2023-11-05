//
//  BillInputView.swift
//  TipCalc
//
//  Created by Anmol Kalra on 02/11/23.
//

import Combine
import CombineCocoa
import UIKit

class BillInputView: UIView {
	
	private let headerView: HeaderView = {
		return HeaderView(topText: "Enter", bottomText: "your bill")
	}()
	
	private let textFieldContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.addCornerRadius(radius: 8.0)
		
		return view
	}()
	
	private let currencySymbolLabel: UILabel = {
		let label = LabelFactory.build(text: "$", font: ThemeFont.bold(of: 24))
		label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		return label
	}()
	
	private lazy var textField: UITextField = {
		let textField = UITextField()
		
		textField.borderStyle = .none
		textField.font = ThemeFont.demiBold(of: 28)
		textField.keyboardType = .decimalPad
		textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
		textField.tintColor = ThemeColor.textColor
		textField.textColor = ThemeColor.textColor
		
		//	Add toolbar
		let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
		toolbar.barStyle = .default
		toolbar.sizeToFit()
		
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped(_:)))
		
		toolbar.items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			doneButton
		]
		toolbar.isUserInteractionEnabled = true
		
		textField.inputAccessoryView = toolbar
		return textField
	}()
	
	private let billSubject: PassthroughSubject<Double, Never> = .init()
	
	var valuePublisher: AnyPublisher<Double, Never> {
		return billSubject.eraseToAnyPublisher()
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		super.init(frame: .zero)
		layout()
		observe()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func observe() {
		textField.textPublisher.sink { [unowned self] text in
			billSubject.send(text?.doubleValue ?? 0)
		}.store(in: &cancellables)
	}
	
	private func layout() {
		[headerView, textFieldContainerView].forEach(addSubview(_:))
		
		headerView.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.centerY.equalTo(textFieldContainerView.snp.centerY)
			make.width.equalTo(68)
			make.height.equalTo(24)
			make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
		}
		
		textFieldContainerView.snp.makeConstraints { make in
			make.top.trailing.bottom.equalToSuperview()
		}
		
		textFieldContainerView.addSubview(currencySymbolLabel)
		textFieldContainerView.addSubview(textField)
		
		currencySymbolLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
		}
		
		textField.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(currencySymbolLabel.snp.trailing).offset(16)
			make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
		}
	}
	
	@objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
		textField.endEditing(true)
	}
}
