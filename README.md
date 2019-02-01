# Swift Dispatchgroup Sample
It is a repository showing a simple example using "DispatchGroup".
(... Test cases will be added.😀)

# Sample Case 01

```swift

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

```

## Result Log

```

2019-01-31 23:54:38 +0000::dispatchGroupTest01(), start
2019-01-31 23:54:38 +0000::dispatchGroupTest01(), end
2019-01-31 23:54:38 +0000::roof30_000_000(), start
2019-01-31 23:54:38 +0000::roof20_000_000(), start
2019-01-31 23:54:38 +0000::roof25_000_000(), start
2019-01-31 23:54:44 +0000::roof20_000_000(), end
2019-01-31 23:54:46 +0000::roof25_000_000(), end
2019-01-31 23:54:47 +0000::roof30_000_000(), end
2019-01-31 23:54:47 +0000::dispatchGroup.notify OK

```
