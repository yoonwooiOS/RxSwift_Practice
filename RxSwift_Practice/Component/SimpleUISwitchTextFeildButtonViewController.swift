//
//  SimpleUISwitchTextFeildButtonViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/30/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SnapKit
import Toast

class SimpleUISwitchTextFeildButtonViewController: UIViewController {
    private let simpleSwitch = UISwitch()
    private let signNameTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBlue
     return textField
    }()
    private let signEmailTextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGreen
     return textField
    }()
    private let signButton =  {
        let button = UIButton()
        button.setTitle("Sign", for: .normal)
        button.backgroundColor = .blue
     return button
    }()
    private let simpleLabel = {
            let label = UILabel()
        label.backgroundColor = .systemGray
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private let spacing = 12
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setSwitch()
        setSing()
    }
    private func setUpView() {
        view.backgroundColor = .white
        setUpHierachy()
        setUpLayout()
        setSwitch()
       
    }
    private func setUpHierachy() {
        [simpleSwitch, signNameTextField, signEmailTextField, signButton, simpleLabel].forEach {
            view.addSubview($0)
        }
    }
    private func setUpLayout() {
        simpleSwitch.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(spacing)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        signNameTextField.snp.makeConstraints { make in
            make.top.equalTo(simpleSwitch.snp.bottom).offset(spacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
        signEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(signNameTextField.snp.bottom).offset(spacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
        signButton.snp.makeConstraints { make in
            make.top.equalTo(signEmailTextField.snp.bottom).offset(spacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(signButton.snp.bottom).offset(spacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.height.equalTo(40)
        }
    }
    private func setSwitch() {
        Observable.of(true)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    private func setSing() {
        Observable.combineLatest(signNameTextField.rx.text.orEmpty, signEmailTextField.rx.text.orEmpty) {
            value1, value2 in
            return "name은 \(value1)이고, email은 \(value2)입니다"
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        signNameTextField.rx.text.orEmpty
            .map { $0.count < 4}
            .bind(to: signEmailTextField.rx.isEnabled, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmailTextField.rx.text.orEmpty
            .map { $0.count > 4}
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                self.view.makeToast("가입되었습니다.")
            }
            .disposed(by: disposeBag)
    }
}
