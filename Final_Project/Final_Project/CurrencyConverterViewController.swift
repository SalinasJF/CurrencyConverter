//
//  CurrencyConverterViewController.swift
//  Final_Project
//
//  Created by CampusUser on 4/28/17.
//  Copyright © 2017 JorgeSalinas. All rights reserved.
//

import UIKit


var converting_Rate: String = "test"
var picker1Options = ["USD", "EUR","GBP"]
var picker2Options = ["USD", "EUR", "GBP"]

class CurrencyConverterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    let semaphoreB = DispatchSemaphore(value: 1)
    
    //variables
    @IBOutlet weak var Current_currency: UIPickerView!
    @IBOutlet weak var Converted_currency: UIPickerView!
    @IBOutlet weak var User_input: UITextField!
    @IBOutlet weak var Currency_output: UITextField!
    @IBOutlet weak var currency_to_be_added: UITextField!
    var cRate: String = "1"
    var value: Float = 1
    var Country_currency1: String = "1"
    var Country_currency2: String = "2"
    
    //Action button
    @IBAction func Add_currency(_ sender: Any) {
        //Add new currency to UIPickers
        if picker2Options.contains(currency_to_be_added.text!){
            //do nothing, picker already has currency
        }
        else{
        picker1Options.append(currency_to_be_added.text!)
        picker2Options.append(currency_to_be_added.text!)
        //upadate UIPickers
        Current_currency .reloadAllComponents()
        Converted_currency.reloadAllComponents()
        }
    }
    
    @IBAction func Converting_button(_ sender: Any) {
        currencyRate(_country: Country_currency2, _country2: Country_currency1)
        value = Float(User_input.text!)!
        value = value / Float(cRate)!
        Currency_output.text = String(value)
        semaphoreB.signal()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeleft:UISwipeGestureRecognizer =
        UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
    
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeleft)
        
        Current_currency.delegate = self
        Converted_currency.delegate = self
        Current_currency.tag = 1
    
    }
    
    //figure out asynchonous closure giving error to string
    func currencyRate (_country: String,_country2: String){
        semaphoreB.wait()
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\""+_country+_country2+"\")"
        myYQL.query(queryString){ jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
            let secDict = queryDict["results"] as! [String: Any]
            let thirdDict = secDict["rate"]  as! [String: Any]
            let convert: String = String(describing: thirdDict["Rate"]!)    //extract only rate
            
            self.save_rate(rate: convert)
            self.semaphoreB.signal()
            //print(String(describing: thirdDict["Rate"]!))
          //  self.save_rate(rate: String(describing: thirdDict["Rate"]!)
        }
        semaphoreB.wait()
    }
    
    func save_rate(rate: String){
        cRate = rate
    }

    //Swipe Function
    func handleSwipe(_ sender:UIGestureRecognizer){
        self.performSegue(withIdentifier: "Show_Currency",sender: self)
    }
    
    //Picker View Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int{ return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return picker1Options.count
        }else{
            return picker2Options.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        //add function to get currently displayed currency in picker view
        if (pickerView.tag == 1){
            Country_currency1 = picker1Options[row]
            return "\(picker1Options[row])"
        }
        else{
            Country_currency2 = picker2Options[row]
            return "\(picker2Options[row])"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Enable unwinding other views
    @IBAction func unwindToCurrency(segue: UIStoryboardSegue){}
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
