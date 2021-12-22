//
//  CustomView.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/18.
//

import Foundation
import UIKit

class CustomView {
    
    static var shared = CustomView()
    
    func viewTypeA(view: UIView) {
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
    }
    
}
