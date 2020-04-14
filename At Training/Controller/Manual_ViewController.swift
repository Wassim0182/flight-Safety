//
//  Manual_ViewController.swift
//  At Training
//
//  Created by WASSIM LAGNAOUI on 2/22/20.
//  Copyright © 2020 WASSIM LAGNAOUI. All rights reserved.
//

import UIKit

class Manual_ViewController: UIViewController {

    // variables
    let valueReceived = 25
    
    // outlets
    
    @IBOutlet weak var visibilityLabel: UILabel!
    
    @IBOutlet weak var ceilingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func visibilitySlider(_ sender: UISlider) {
        let temp = sender.value
              let temp1 = temp*4
              let temp2 = roundf(temp1)
              let temp3 = temp2/4
              
              let tempS = String(temp3)
              visibilityLabel.text = tempS
        
        
    }
    
    
    @IBAction func ceilingSlider(_ sender: UISlider) {
             let temp = sender.value
             let tempI = Int(temp)
             let tempS = String(Int(temp))
             ceilingLabel.text = tempS
          
    }
    
    
   
    @IBAction func InitiatePressed(_ sender: UIButton) {
        
        print(db.integer(forKey: "Min_Pitch"))
        print(valueReceived)
        
    }
  

}
