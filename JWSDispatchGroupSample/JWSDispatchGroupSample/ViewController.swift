//
//  ViewController.swift
//  JWSDispatchGroupSample
//
//  Created by Clint on 01/02/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCase1(_ sender: Any) {
        dispatchGroupTestCase1Notify()
    }
    
    @IBAction func onCase2(_ sender: Any) {
        dispatchGroupTestCase2Wait()
    }
    
    @IBAction func onCase3(_ sender: Any) {
        dispatchGroupTestCase3QueueNotify()
    }
}

// MARK: - Log
extension ViewController {
    func writeLog(_ text: String) {
        let log = "\(Date())::\(text)"
        print(log)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let beforeLog = self.textView.text else { return }
            let fullLog = "\(beforeLog)\n\(log)"
            self.textView.text = fullLog
            self.textView.scrollToBottom()
        }
        
    }
}

// MARK: -
extension ViewController {
    
    // MARK: Case 1 (notify, asynchronous)
    
    func dispatchGroupTestCase1Notify() {
        writeLog("=====================\n== asynchronous")
        writeLog("\(#function), start")
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof20_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof10_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof15_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.writeLog("dispatchGroup.notify OK")
            self.writeLog("\(#function), end")
        }
    }
    
    // MARK: Case 2 (wait, synchronous)
    
    func dispatchGroupTestCase2Wait() {
        writeLog("=====================\n== synchronous")
        writeLog("\(#function), start")
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof20_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof10_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof15_000_000() { dispatchGroup.leave() }
        }
        
        let result = dispatchGroup.wait(timeout: .distantFuture)
        self.writeLog("dispatchGroup.wait OK(result::\(result))")
        self.writeLog("\(#function), end")
    }
    
    // MARK: Case 3 (queue, notify, asynchronous, Do not use enter and leave.)
    
    func dispatchGroupTestCase3QueueNotify() {
        writeLog("=====================\n== asynchronous")
        writeLog("=====================\n== Do not use enter and leave.")
        writeLog("\(#function), start")
        let dispatchGroup = DispatchGroup()
        let dispatchQueueGlobal = DispatchQueue.global()
        
        dispatchQueueGlobal.async(group: dispatchGroup, execute: { [weak self] in
            guard let self = self else { return }
            let _ = self.roof20_000_000()
        })
        
        dispatchQueueGlobal.async(group: dispatchGroup, execute: { [weak self] in
            guard let self = self else { return }
            let _ = self.roof10_000_000()
        })
        
        dispatchQueueGlobal.async(group: dispatchGroup, execute: { [weak self] in
            guard let self = self else { return }
            let _ = self.roof15_000_000()
        })
        
        dispatchGroup.notify(queue: dispatchQueueGlobal) { [weak self] in
            guard let self = self else { return }
            self.writeLog("dispatchGroup.notify OK")
            self.writeLog("\(#function), end")
        }
    }
}

// MARK: - Utils
extension ViewController {
    func roof10_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...10_000_000).forEach { _ in }
        writeLog("\(#function), end")
        return true
    }
    
    func roof15_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...15_000_000).forEach { _ in }
        writeLog("\(#function), end")
        return true
    }
    
    func roof20_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...20_000_000).forEach { _ in }
        writeLog("\(#function), end")
        return true
    }
}

extension UITextView {
    func scrollToBottom() {
        let textCount: Int = text.count
        guard textCount >= 1 else { return }
        scrollRangeToVisible(NSMakeRange(textCount - 1, 1))
    }
}
