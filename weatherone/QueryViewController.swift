//
//  QueryViewController.swift
//  weatherone
//
//  Created by huqy on 2025/5/31.
//

import UIKit

protocol QueryViewControllerDelegate{
    func didchangecity(city:String)
}

class QueryViewController: UIViewController {

    var currentcity = ""
    var delegate:QueryViewControllerDelegate?
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var currentcitylabel: UILabel!
    
    @IBOutlet weak var citytextfield: UITextField!
    
    @IBAction func query(_ sender: Any) {
        dismiss(animated: true)
        
        if !citytextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            delegate?.didchangecity(city:citytextfield.text!)
            print("执行了didchangecity")
            print(citytextfield.text!)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        citytextfield.becomeFirstResponder()
        currentcitylabel.text = ("当前城市:\(currentcity)")
        print("加载搜索页面")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
