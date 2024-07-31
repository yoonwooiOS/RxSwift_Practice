//
//  SimpleValidationViewController.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimpleValidationViewController: BaseViewController {
    private let usernameLabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    private let userPasswordLabel = {
        let label = UILabel()
        label.text = "PassWord"
        return label
    }()
    
    private let usernameTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        return tf
    }()
    private let usernameValidLabel = {
        let label = UILabel()
        
        return label
    }()
    private let userpasswordTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        return tf
    }()
    private let userpasswordValidLabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let completeButton = {
        let btn = UIButton()
        btn.setTitle("확인", for: .normal)
        btn.setTitleColor(.systemGreen, for: .normal)
        return btn
    }()
    private let disposeBag = DisposeBag()
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserIdPwValidation()
    }
    override func setUpHierarchy() {
        [usernameLabel,userPasswordLabel,usernameTextField, usernameValidLabel, userpasswordTextField, userpasswordValidLabel, completeButton ].forEach {
            view.addSubview($0)
        }
    }
    override func setUpLayout() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        userPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        userpasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(userPasswordLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        userpasswordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(userpasswordTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(userpasswordValidLabel.snp.bottom).offset(40)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }

    }
    
    private func setUpUserIdPwValidation() {
        usernameValidLabel.text = "닉네임은 \(minimalUsernameLength)글자 이상이여야 합니다"
        userpasswordValidLabel.text = "비밀번호는 \(minimalPasswordLength)글자 이상이여야 합니다"
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        let passwordValid = userpasswordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength}
            .share(replay: 1)
        let everthingValid = Observable.combineLatest(usernameValid, passwordValid) {$0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: userpasswordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValid
            .bind(to:  userpasswordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        everthingValid
            .bind(to: completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
     
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
