//
//  ViewController.swift
//  CurrencyCalculator
//
//  Created by Enes Kaya on 19.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel:  UILabel!
    @IBOutlet weak var gbpLabel:  UILabel!
    @IBOutlet weak var jpyLabel:  UILabel!
    @IBOutlet weak var usdLabel:  UILabel!
    @IBOutlet weak var tryLabel:  UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRates(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=a723bca47584e48b80441c3e8332d465")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if (error != nil){
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                    
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                if let cad = rates["CAD"] as? Double{
                                    let cadRound = Double(round(1000 * cad) / 1000)
                                    self.cadLabel.text = "CAD: \(cadRound)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    let gbpRound = Double(round(1000 * gbp) / 1000)
                                    self.gbpLabel.text = "GBP: \(gbpRound)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    let jpyRound = Double(round(1000 * jpy) / 1000)
                                    self.jpyLabel.text = "JPY: \(jpyRound)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    let usdRound = Double(round(1000 * usd) / 1000)
                                    self.usdLabel.text = "USD: \(usdRound)"
                                }
                                if let Turkish = rates["TRY"] as? Double{
                                    let tryRound = Double(round(1000 * Turkish) / 1000)
                                    self.tryLabel.text = "TRY: \(tryRound)"
                                }
                                if let eur = rates["EUR"] as? Double{
                                    let eurRound = Double(round(1000 * eur) / 1000)
                                    self.euroLabel.text = "EUR: \(eurRound)"
                                }
                                
                                
                                
                            }
                                
                                
                            
                            
                        }
                    }
                    catch{
                        print("error")
                    }
                    
                    
                }
            }
            
        }
        
        task.resume()
        
    }
    
}

