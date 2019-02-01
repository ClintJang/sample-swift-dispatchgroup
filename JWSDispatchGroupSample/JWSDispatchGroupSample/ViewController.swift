//
//  ViewController.swift
//  JWSDispatchGroupSample
//
//  Created by Clint on 01/02/2019.
//  Copyright © 2019 ClintJang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatchGroupTest01()
    }
}

extension ViewController {
    func dispatchGroupTest01() {
        print("\(Date())::\(#function), start")
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
        
        dispatchGroup.notify(queue: .main) {
            print("\(Date())::dispatchGroup.notify OK")
        }
        print("\(Date())::\(#function), end")
    }
}

extension ViewController {
    func roof20_000_000() -> Bool {
        print("\(Date())::\(#function), start")
        (0...20_000_000).forEach { _ in }
        print("\(Date())::\(#function), end")
        return true
    }
    
    func roof25_000_000() -> Bool {
        print("\(Date())::\(#function), start")
        (0...25_000_000).forEach { _ in }
        print("\(Date())::\(#function), end")
        return true
    }
    
    func roof30_000_000() -> Bool {
        print("\(Date())::\(#function), start")
        (0...30_000_000).forEach { _ in }
        print("\(Date())::\(#function), end")
        return true
    }
}

