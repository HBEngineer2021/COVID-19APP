//
//  ViewController.swift
//  COVID-19APP
//
//  Created by Motoki Onayama on 2021/12/17.
//

import UIKit

class ViewController: UIViewController, AlertViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var selectInfoView: UIView! {
        didSet {
            CustomView.shared.viewTypeA(view: selectInfoView)
        }
    }
    
    @IBOutlet weak var decisionBtn: UIButton! {
        didSet {
            CustomButton.shared.btnTypeA(btn: decisionBtn)
        }
    }
    
    @IBOutlet weak var searchBtn: UIButton! {
        didSet {
            CustomButton.shared.btnTypeA(btn: searchBtn)
            searchBtn.isEnabled = false
        }
    }
    
    @IBOutlet weak var countryLbl: UILabel! {
        didSet {
            countryLbl.text = "-"
        }
    }
    
    @IBOutlet weak var dateLbl: UILabel! {
        didSet {
            dateLbl.text = "-"
        }
    }
    
    let countryArray = ["Japan","Afghanistan","Albania","Algeria","Andorra"]
    var selectCountry: String?
    
    let indicator = UIActivityIndicatorView()
    let indicatorBackground = UIView()
    let background = UIView()
    
    var country: String!
    var date: String!
    var latitude: String!
    var longitude: String!
    var active: String!
    var confirmed: String!
    var deaths: String!
    var recovered: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogManager.shared.createFile()
        setPickerView()
        setDatePicker()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func decisionAction(_ sender: Any) {
        setInfo()
        searchBtn.isEnabled = true
    }
    
    @IBAction func searchAction(_ sender: Any) {
        covid19ApiAction()
    }
    
    private func covid19Api(country: String, date: String) {
        
        let headers = [
            "x-rapidapi-key": "895ad8b605msh8eea7195dc8870ap1e9ab3jsne7b29aab8e7d",
            "x-rapidapi-host": "covid-19-data.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-data.p.rapidapi.com/report/country/name?name=\(country)&date=\(date)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                let decode = JSONDecoder()
                let value = try decode.decode([Country].self, from: data!)
                self.log(json: json)
                self.log(json: value[0].country)
                ResultViewController.country = value[0].country
                self.log(json: value[0].date)
                ResultViewController.date = value[0].date
                self.log(json: value[0].latitude)
                ResultViewController.latitude = value[0].latitude
                self.log(json: value[0].longitude)
                ResultViewController.longitude = value[0].longitude
                self.log(json: value[0].provinces[0].active ?? 0)
                ResultViewController.active = value[0].provinces[0].active ?? 0
                self.log(json: value[0].provinces[0].confirmed ?? 0)
                ResultViewController.confirmed = value[0].provinces[0].confirmed ?? 0
                self.log(json: value[0].provinces[0].deaths ?? 0)
                ResultViewController.deaths = value[0].provinces[0].deaths ?? 0
                self.log(json: value[0].provinces[0].province ?? "ありません")
                self.log(json: value[0].provinces[0].recovered ?? 0)
                ResultViewController.recovered = value[0].provinces[0].recovered ?? 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.indicator.stopAnimating()
                    self.indicatorBackground.removeFromSuperview()
                    self.background.removeFromSuperview()
                    let vc = ResultViewController.init(nibName: "ResultViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                    _ = self.success(title: "成功")
                }
            }
            catch {
                let error = error as NSError
                self.log(json: "convert failure!")
                self.log(json: "localizedDescription：\(error.localizedDescription)")
                self.log(json: "code：\(error.code)")
                self.log(json: "domain：\(error.domain)")
                self.log(json: "underlyingErrors：\(error.underlyingErrors)")
                self.log(json: "userInfo：\(error.userInfo)")
                self.log(json: "localizedFailureReason：\(String(describing: error.localizedFailureReason))")
                self.log(json: "localizedRecoverySuggestion：\(String(describing: error.localizedRecoverySuggestion))")
                self.log(json: "localizedRecoveryOptions：\(String(describing: error.localizedRecoveryOptions))")
                self.log(json: "debugDescription：\(error.debugDescription)")
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.indicatorBackground.removeFromSuperview()
                    self.background.removeFromSuperview()
                    _ = self.failure(title: "変換に失敗しました。", retry: "再変換") { (UIAlertAction) -> Void in
                        self.covid19ApiAction()
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    private func log(json: Any) {
        _ = LogManager.shared.printer(object: json)
        LogManager.shared.write()
    }
    
    private func setPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.locale = .current
        datePicker.timeZone = .current
    }
    
    private func dateSelect(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        log(json: df.string(from: date))
        return df.string(from: date)
    }
    
    private func setInfo() {
        DispatchQueue.main.async {
            self.countryLbl.text = self.selectCountry
            self.dateLbl.text = self.dateSelect(date: self.datePicker.date)
        }
    }
    
    private func setIndicator() {
        indicator.style = .large
        indicator.color = UIColor.green
        indicator.center = view.center
        indicatorBackground.center = view.center
        indicatorBackground.backgroundColor = UIColor.systemGray6
        indicatorBackground.layer.bounds.size.height = UIScreen.main.bounds.width/2
        indicatorBackground.layer.bounds.size.width = UIScreen.main.bounds.width/2
        indicatorBackground.layer.borderWidth = 1
        indicatorBackground.layer.borderColor = UIColor.clear.cgColor
        indicatorBackground.layer.cornerRadius = 10
        background.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        background.center = view.center
        background.layer.bounds.size.height = UIScreen.main.bounds.height
        background.layer.bounds.size.width = UIScreen.main.bounds.width
        self.view.addSubview(background)
        self.view.addSubview(indicatorBackground)
        self.view.addSubview(indicator)
    }
    
    private func covid19ApiAction() {
        covid19Api(country: countryLbl.text!, date: dateLbl.text!)
        setIndicator()
        indicator.startAnimating()
    }
    
    /*func testModelJson() {
        let decode = JSONDecoder()
        let encoder = JSONEncoder()
        let obj = [Country(country: "", date: "", latitude: 43.6, longitude: 43.4, provinces: [Country.Provinces(active: 32, confirmed: 32, deaths: 43, province: "", recovered: 32)])]
        do {
            encoder.outputFormatting = .prettyPrinted
            //let data = try encoder.encode(obj)
            //let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            //let value = try decode.decode([Country].self, from: data)
            //log(json: value)
            //log(json: json)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }*/
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectCountry = countryArray[row]
        return selectCountry
    }
    
}
