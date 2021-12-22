//
//  CustomButton.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/18.
//

import Foundation
import UIKit

class CustomButton {
    
    static var shared = CustomButton()
    
    func btnTypeA(btn: UIButton) {
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
    }
    
}
