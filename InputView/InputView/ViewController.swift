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
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("打开", for: .normal)
        btn.frame = CGRect.init(x: 100, y: 100, width: 80, height: 40)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
        
        label.frame = CGRect.init(x: 10, y: 200, width: self.view.frame.width - 20, height: 40)
        label.textAlignment = .center
        label.backgroundColor = UIColor.green
        self.view.addSubview(label)
        label.text = "密码为: 223366"
        input.delegate = self
        input.count = "20000"
    }

    func btnClick() {
        
        input.showIn(self.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // LZInputViewDelegate
    func inputView(_ view: LZInputView, didEndInput result: String) {
        
        print(result)
        
        if result == "223366" {
            view.dismiss()
            label.text = "您输入的密码为\(result),输入正确"
        } else {
            view.shake()
            view.resetInput()
        }
    }

}

