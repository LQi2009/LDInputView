//
//  ViewController.swift
//  InputView
//
//  Created by Artron_LQQ on 2016/11/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LZInputViewDelegate {

    let input: LZInputView = LZInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.addSubview(input)
//        input.getResult { (str) in
//            
//            print("<>>>>>> ",str)
//        }
        
        
        
        let arr = ["aa","bb","cc"]
        
        let str = arr.joined()
        
        print(str)
        
        input.delegate = self
        input.count = "20000"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        input.showIn(self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // LZInputViewDelegate
    func inputView(_ view: LZInputView, didEndInput result: String) {
        
        print(result)
        view.dismiss()
    }

}

