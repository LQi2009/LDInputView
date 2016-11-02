//
//  LZNumInputView.swift
//  InputView
//
//  Created by Artron_LQQ on 2016/11/1.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

//typealias backBlock = (_ result: String)->Void
private let inputViewHeight: CGFloat = 360.0

class LZInputView: UIView, UITextFieldDelegate {
    
    // 代理
    var delegate: LZInputViewDelegate?
    // 金额
    var count: String = "0" {
        
        didSet {
            
            self.countLabel.text = count
        }
    }
    
    
    private let bgView: UIView = UIView()
    private var inputs: [String] = []
    private var showLabels: [UILabel] = []
    private var textField: UITextField!
    private var countLabel: UILabel!
    private var maskingView: UIView!
    private var subBgView: UIView!
//    var result: backBlock?
    
    
    deinit {
        
        print("deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.frame = UIScreen.main.bounds
        
        self.backgroundColor = UIColor.clear
        
        self.setupMain()
        
        self.addObserver()
    }
    
    func showIn(_ view: UIView) {
        
        view.addSubview(self)
        self.textField.becomeFirstResponder()
        self.maskingView.alpha = 0.6
    }
    
    func dismiss() {
        
        self.endEditing(true)
    }
    
    // 重置: 清空数组,重置视图
    func resetInput() {
        
        self.inputs.removeAll()
        for label in showLabels {
            
            label.text = ""
        }
    }
    
    func shake() {
        
        self.resetInput()
        
        let kfa = CAKeyframeAnimation.init(keyPath: "transform.translation.x")
        
        let s: CGFloat = 5.0
        
        kfa.values = [-s, 0, s, 0, -s, 0, s, 0]
        
        kfa.duration = 0.3
        
        kfa.repeatCount = 2
        kfa.isRemovedOnCompletion = true
        
        subBgView.layer.add(kfa, forKey: "shake")
    }
    
//    func getResult(_ result: @escaping backBlock) {
//        
//        self.result = result
//    }
    // 添加监控键盘弹出/消失的观察者
    private func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDismiss), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    // 键盘弹出
    @objc private func keyboardShow(noti: Notification) {
        
        let dic = noti.userInfo
        
        let interval = dic?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        var frame = self.bgView.frame
        
        let raw = dic?[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        frame.origin.y = self.frame.height - inputViewHeight
        
        UIView.animate(withDuration: (interval), delay: 0, options: UIViewAnimationOptions(rawValue: raw ), animations: {
            
            self.bgView.frame = frame
        }, completion: { end in
            
        })
    }
    // 键盘消失
    @objc private func keyboardDismiss(noti: Notification) {
        
        let dic = noti.userInfo
        
        let interval = dic?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        let raw = dic?[UIKeyboardAnimationCurveUserInfoKey] as! UInt

        var frame = self.bgView.frame
        
        frame.origin.y = self.frame.height
        
        UIView.animate(withDuration: TimeInterval(interval), delay: 0, options: UIViewAnimationOptions(rawValue: raw), animations: {
            
            self.bgView.frame = frame
            self.maskingView.alpha = 0
            
        }, completion: { end in
            // 键盘消失后移除, 重置
            self.removeFromSuperview()
            self.resetInput()
        })
    }
    
    
    private func setupMain() {
        
        maskingView = UIView.init()
        maskingView.frame = self.bounds
        maskingView.backgroundColor = UIColor.black
        maskingView.alpha = 0.6
        self.addSubview(maskingView)
        
        bgView.backgroundColor = UIColor.white
        bgView.frame = CGRect.init(x: 0, y: self.frame.height, width: self.frame.width, height: inputViewHeight)
        self.addSubview(bgView)
        
        let backBtn = UIButton.init(type: .custom)
        
        backBtn.setTitleColor(UIColor.blue, for: .normal)
        backBtn.setTitle("<", for: .normal)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 30)
        backBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        bgView.addSubview(backBtn)
        
        
        let titleLabel = UILabel.init()
        titleLabel.text = "请输入密码"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.green
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect.init(x: 60, y: 0, width: self.frame.width - 120, height: 34)
        bgView.addSubview(titleLabel)
        
        let line = UIView.init()
        line.backgroundColor = UIColor.gray
        line.frame = CGRect.init(x: 10, y: titleLabel.frame.maxY + 4, width: self.frame.width - 20, height: 1)
        bgView.addSubview(line)
        
        
        let countLabel = UILabel.init()
        
        countLabel.text = "$300"
        countLabel.font = UIFont.systemFont(ofSize: 16)
        countLabel.textColor = UIColor.red
        countLabel.textAlignment = .center
        countLabel.frame = CGRect.init(x: 20, y: line.frame.maxY, width: self.frame.width - 40, height: 30)
        bgView.addSubview(countLabel)
        self.countLabel = countLabel
        
        let tf = UITextField.init()
        tf.frame = CGRect.init(x: 60, y: countLabel.frame.maxY+5, width: self.frame.width - 120, height: 20)
        tf.becomeFirstResponder()
        tf.delegate = self
        bgView.addSubview(tf)
        
        tf.keyboardType = .numberPad
        textField = tf
        
        
        let leftMargin: CGFloat = 30.0
        subBgView = UIView.init()
        subBgView.backgroundColor = UIColor.gray
        subBgView.frame = CGRect.init(x: 30, y: countLabel.frame.maxY + 4, width: self.frame.width - leftMargin*2, height: 40)
        bgView.addSubview(subBgView)
        
        let space: CGFloat = 1
        let width: CGFloat = (self.frame.width - leftMargin*2 - space*7)/6.0
        
        for i in 0..<6 {
            
            let label = UILabel.init()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.frame = CGRect.init(x: space + (width + space)*CGFloat(i), y: space, width: width, height: 40-2*space)
            label.backgroundColor = UIColor.white
            subBgView.addSubview(label)
            
//            label.text = "\(i)"
            
            self.showLabels.append(label)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count > 0 {
            
            print(string)
            if self.inputs.count>=6 {
                
                return false
            }
            
            self.inputs.append(string)
            let label = self.showLabels[self.inputs.count - 1]
            
            label.text = "•"
            
            if self.inputs.count == 6 {
                
                let str = self.inputs.joined()
                if let delegate = self.delegate {
                    
                    delegate.inputView(self, didEndInput: str)
                }
            }
            
        } else {
            
            if self.inputs.count<=0 {
                
                return false
            }
            
            self.inputs.removeLast()
            let label = self.showLabels[self.inputs.count]
            label.text = ""
        }
        return true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.endEditing(true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol LZInputViewDelegate {
    
    func inputView(_ view: LZInputView, didEndInput result: String)
}
