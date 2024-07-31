//
//  ObservableExampleViewContorller.swift
//  RxSwift_Practice
//
//  Created by 김윤우 on 7/30/24.
//

import UIKit
import RxSwift

class ObservableExampleViewContorller: UIViewController {
    let disposeBag = DisposeBag()
    let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
    let itemsB = [2.3, 2.0, 1.3]
    override func viewDidLoad() {
        super.viewDidLoad()
        just()
        of()
        from()
        take()
    }
    private func just() {
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
    }
    private func of() {
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
    }
    private func from() {
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    private func take() {
        Observable.repeatElement(itemsA)
            .take(5)
            .subscribe { value in
                print("take - \(value)")
            } onError: { error in
                print("take - \(error)")
            } onCompleted: {
                print("take completed")
            } onDisposed: {
                print("take disposed")
            }
            .disposed(by: disposeBag)
    }
}

