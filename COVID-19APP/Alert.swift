//
//  Alert.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/22.
//

import Foundation
import UIKit

/// UIViewControllerで使用する
protocol AlertViewController where Self: UIViewController {
   
    /// 成功
    /// - Parameter title: アラートのタイトル
   func success(title: String) -> Bool
   
    /// 失敗
    /// - Parameters:
    ///   - title: アラートのタイトル
    ///   - retry: 再実行ボタン（※ 文言が変わる場合は、引数にする）
    ///   - handler: 処理させたい内容を書く
   func failure(title: String, retry: String, handler: ((UIAlertAction) -> Void)?) -> Bool
}

extension AlertViewController {
   
   func success(title: String) -> Bool {
       let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
       let cancel: UIAlertAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default, handler: nil)
       alert.addAction(cancel)
       present(alert, animated: true, completion: nil)
       return true
   }
   
   func failure(title: String, retry: String, handler: ((UIAlertAction) -> Void)?) -> Bool {
       let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
       let action: UIAlertAction = UIAlertAction(title: retry, style: UIAlertAction.Style.default, handler: handler)
       let cancel: UIAlertAction  = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default, handler: nil)
       alert.addAction(action)
       alert.addAction(cancel)
       present(alert, animated: true, completion: nil)
       return true
   }
}

/// UIVIewで使用する
protocol AlertView where Self: UIView {
    
    /// 成功
    /// - Parameter title: アラートのタイトル
   func success(title: String) -> Bool
   
    /// 失敗
    /// - Parameters:
    ///   - title: アラートのタイトル
    ///   - retry: 再実行ボタン（※ 文言が変わる場合は、引数にする）
    ///   - handler: 処理させたい内容を書く
   func failure(title: String, retry: String, handler: ((UIAlertAction) -> Void)?) -> Bool
}

extension AlertView {
   
   func success(title: String) -> Bool {
       let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
       let cancel: UIAlertAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default, handler: nil)
       alert.addAction(cancel)
       let window = UIApplication.shared.windows.first { $0.isKeyWindow }
       window?.rootViewController?.present(alert, animated: true, completion: nil)
       return true
   }
   
   func failure(title: String, retry: String, handler: ((UIAlertAction) -> Void)?) -> Bool {
       let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
       let action: UIAlertAction = UIAlertAction(title: retry, style: UIAlertAction.Style.default, handler: handler)
       let cancel: UIAlertAction  = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default, handler: nil)
       alert.addAction(action)
       alert.addAction(cancel)
       let window = UIApplication.shared.windows.first { $0.isKeyWindow }
       window?.rootViewController?.present(alert, animated: true, completion: nil)
       return true
   }
}
