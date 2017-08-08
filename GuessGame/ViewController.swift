//
//  檔名： ViewController.swift
//  專案： GuessGame
//
//  《Swift 入門指南》 V3.00 的範例程式
//  購書連結
//         Google Play  : https://play.google.com/store/books/details?id=AO9IBwAAQBAJ
//         iBooks Store : https://itunes.apple.com/us/book/id1079291979
//         Readmoo      : https://readmoo.com/book/210034848000101
//         Pubu         : http://www.pubu.com.tw/ebook/65565?apKey=576b20f092
//
//  作者網站： http://www.kaiching.org
//  電子郵件： kaichingc@gmail.com
//
//  作者： 張凱慶
//  時間： 2017/08/01
//

import Cocoa
import GameplayKit

class ViewController: NSViewController {
    //MARK: 屬性
    
    //答案
    var answer: Int? = nil
    var answerArray = [Int]()
    
    //使用者輸入
    var userinput = -1
    var userinputString = ""
    var userInputArray = [Int]()
    
    //位數與計次
    var digit = 0
    var aCounter = 0
    var bCounter = 0
    var count = 0
    
    //MARK: 視窗屬性
    @IBOutlet weak var displayNumbers: NSTextField!
    @IBOutlet weak var displayTimes: NSTextField!
    @IBOutlet weak var displayResults: NSScrollView!
    @IBOutlet var displayText: NSTextView!
    @IBOutlet weak var replace: NSButton!
    @IBOutlet weak var button0: NSButton!
    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var button3: NSButton!
    @IBOutlet weak var button4: NSButton!
    @IBOutlet weak var button5: NSButton!
    @IBOutlet weak var button6: NSButton!
    @IBOutlet weak var button7: NSButton!
    @IBOutlet weak var button8: NSButton!
    @IBOutlet weak var button9: NSButton!
        
    //MARK: 視窗方法
    
    //新遊戲按鈕
    @IBAction func newGame(_ sender: NSButton) {
        //顯示結果區清空
        displayText!.string = ""
        
        //設定答案
        answerArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        while true {
            answerArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: answerArray) as! [Int]
            
            if answerArray[0] != 0 {
                break
            }
        }
        
        answerArray = [answerArray[0], answerArray[1], answerArray[2], answerArray[3]]
        answer = answerArray[0] * 1000 + answerArray[1] * 100 + answerArray[2] * 10 + answerArray[3]
        
        //歸零
        reset()
        count = 0
        
        //設定訊息
        displayNumbers.stringValue = ""
        displayTimes.stringValue = "0"
        displayText.textStorage?.append(NSAttributedString(string: "開始遊戲\n"))
    }
    
    //重來按鈕
    @IBAction func replaceMethod(_ sender: NSButton) {
        reset()
    }
    
    //按鈕0
    @IBAction func method0(_ sender: NSButton) {
        userinput = 0
        next()
    }
    
    //按鈕1
    @IBAction func method1(_ sender: NSButton) {
        userinput = 1
        next()
    }
    
    //按鈕2
    @IBAction func method2(_ sender: NSButton) {
        userinput = 2
        next()
    }
    
    //按鈕3
    @IBAction func method3(_ sender: NSButton) {
        userinput = 3
        next()
    }
    
    //按鈕4
    @IBAction func method4(_ sender: NSButton) {
        userinput = 4
        next()
    }
    
    //按鈕5
    @IBAction func method5(_ sender: NSButton) {
        userinput = 5
        next()
    }
    
    //按鈕6
    @IBAction func method6(_ sender: NSButton) {
        userinput = 6
        next()
    }
    
    //按鈕7
    @IBAction func method7(_ sender: NSButton) {
        userinput = 7
        next()
    }
    
    //按鈕8
    @IBAction func method8(_ sender: NSButton) {
        userinput = 8
        next()
    }
    
    //按鈕9
    @IBAction func method9(_ sender: NSButton) {
        userinput = 9
        next()
    }
    
    //MARK: 方法
    
    //按下按鈕後統一處理
    func next() {
        //位數遞增
        digit += 1
        
        //顯示使用者輸入
        displayNumbers.stringValue.append(String(userinput))
        
        //將使用者輸入加入答案陣列
        userInputArray.append(userinput)
        
        //處理重複數字
        switch userinput {
        case 0:
            button0.isEnabled = false
        case 1:
            button1.isEnabled = false
        case 2:
            button2.isEnabled = false
        case 3:
            button3.isEnabled = false
        case 4:
            button4.isEnabled = false
        case 5:
            button5.isEnabled = false
        case 6:
            button6.isEnabled = false
        case 7:
            button7.isEnabled = false
        case 8:
            button8.isEnabled = false
        case 9:
            button9.isEnabled = false
        default:
            lockButtons()
        }
        
        //將0改成可按
        if !userInputArray.contains(0) {
            button0.isEnabled = true
        }
        
        //猜完一次
        if digit == 4 {
            count += 1
            displayTimes.stringValue = String(count)
            
            userinputString = displayNumbers.stringValue
            
            //計算AB值
            for i in userInputArray {
                if answerArray.contains(i) {
                    if userInputArray.index(of: i) == answerArray.index(of: i) {
                        aCounter += 1
                    }
                    else {
                        bCounter += 1
                    }
                }
            }
            
            //結果處理
            if aCounter == 4 {
                //結束遊戲
                displayText.textStorage?.append(NSAttributedString(string: userinputString + " 猜中！\n"))
                lockButtons()
            }
            else {
                //顯示結果
                displayText.textStorage?.append(NSAttributedString(string: userinputString + ":" + String(aCounter) + "A" + String(bCounter) + "B" + "\n"))
                //歸零
                reset()
            }
        }
    }
    
    //歸零
    func reset() {
        userinput = -1
        userinputString = ""
        userInputArray.removeAll()
        displayNumbers.stringValue = ""
        digit = 0
        aCounter = 0
        bCounter = 0
        unlockButtons()
        //第一位數不能為0
        button0.isEnabled = false
    }
    
    //將按鈕鎖上
    func lockButtons() {
        replace.isEnabled = false
        button0.isEnabled = false
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        button5.isEnabled = false
        button6.isEnabled = false
        button7.isEnabled = false
        button8.isEnabled = false
        button9.isEnabled = false
    }
    
    //將按鈕打開
    func unlockButtons() {
        replace.isEnabled = true
        button0.isEnabled = true
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        button5.isEnabled = true
        button6.isEnabled = true
        button7.isEnabled = true
        button8.isEnabled = true
        button9.isEnabled = true
    }
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        displayText!.string = ""
        lockButtons()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

