//
//  ResultViewController.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/18.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var latitudeLbl: UILabel!
    
    @IBOutlet weak var longitudeLbl: UILabel!
    
    @IBOutlet weak var activeLbl: UILabel!
    
    @IBOutlet weak var confirmedLbl: UILabel!
    
    @IBOutlet weak var deathsLbl: UILabel!
    
    @IBOutlet weak var recoveredLbl: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton! {
        didSet {
            CustomButton.shared.btnTypeA(btn: closeBtn)
        }
    }
    
    static var country: String?
    static var date: String?
    static var latitude: Double?
    static var longitude: Double?
    static var active: Int?
    static var confirmed: Int?
    static var deaths: Int?
    static var recovered: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synchronize()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func synchronize() {
        self.countryLbl.text = ResultViewController.country
        self.dateLbl.text = ResultViewController.date
        self.latitudeLbl.text = ResultViewController.latitude?.description
        self.longitudeLbl.text = ResultViewController.longitude?.description
        self.activeLbl.text = ResultViewController.active?.description
        self.confirmedLbl.text = ResultViewController.confirmed?.description
        self.deathsLbl.text = ResultViewController.deaths?.description
        self.recoveredLbl.text = ResultViewController.recovered?.description
    }
    
}
