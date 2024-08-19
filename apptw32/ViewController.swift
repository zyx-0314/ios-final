//
//  ViewController.swift
//  apptw32
//
//  Created by Roman De Angel on 11/22/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnplist(_ sender: Any) {
        let file = Bundle.main.path(forResource: "myitems", ofType: "plist") ?? ""
        let itemArr = NSArray(contentsOfFile: file) ?? []
    
//        let itemDict = itemArr![0] as! Dictionary<String, String>
//        print(itemDict["name"]!)
        
        for itemDict in itemArr{
            let item = itemDict as! Dictionary<String, String>
            print(item["name"]!, item["price"]!, item["description"]!)
        }
        
    }
    
    @IBAction func btnjsonapi(_ sender: Any) {
        guard let url = URL(string: "https://www.floatrates.com/daily/usd.json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else { return }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data , options: []) as? [String: Any] {
                    for (country, rateDetails) in json{
                        if let curr = json[country] as? [String: Any]{
//                            print(curr["name"]!, curr["rate"]!, curr["date"]!)
                            print(curr["name"]!, curr["rate"]!)
                        }
                    }
                    

                }
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        task.resume()
        
        
    }
}

