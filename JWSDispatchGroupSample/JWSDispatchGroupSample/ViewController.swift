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
        dispatchGroupTestCase01()
    }
}

/// MARK: - Log
extension ViewController {
    func writeLog(_ text: String) {
        let log = "\(Date())::\(text)"
        print(log)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let beforeLog = self.textView.text else { return }
            let fullLog = "\(beforeLog)\n\(log)"
            self.textView.text = fullLog
        }
        
    }
}
/// MARK: -
/// MARK: Case 1
extension ViewController {
    func dispatchGroupTestCase01() {
        writeLog("\(#function), start")
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof30_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof20_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.enter()
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if self.roof25_000_000() { dispatchGroup.leave() }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.writeLog("dispatchGroup.notify OK")
            self.writeLog("\(#function), end")
        }
    }
}

extension ViewController {
    func roof20_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...20_000_000).forEach { _ in }
        print("\(Date())::\(#function), end")
        return true
    }
    
    func roof25_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...25_000_000).forEach { _ in }
        writeLog("\(#function), end")
        return true
    }
    
    func roof30_000_000() -> Bool {
        writeLog("\(#function), start")
        (0...30_000_000).forEach { _ in }
        writeLog("\(#function), end")
        return true
    }
}

