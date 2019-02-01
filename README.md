# Swift Dispatchgroup Sample
It is a repository showing a simple example using "DispatchGroup". <br />
Jobs already in group via DispatchGroup
Wait for it to finish and use it when you expect it to be called when it's all done.

- "notify" works asynchronously.
- "wait" works synchronously.

## Result Image (GIF)
<img width="400" src="/Image/resultInfo.gif">

## Case 01 (notify)
> asynchronous

```swift

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

```

## Case 02 (wait)
> synchronous

```swift
	
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

```

## Result Log

### case 1 (notify, asynchronous)

```

2019-02-01 06:24:24 +0000::=====================
== asynchronous
2019-02-01 06:24:24 +0000::dispatchGroupTestCase1Notify(), start
2019-02-01 06:24:24 +0000::roof20_000_000(), start
2019-02-01 06:24:24 +0000::roof10_000_000(), start
2019-02-01 06:24:28 +0000::roof10_000_000(), end
2019-02-01 06:24:28 +0000::roof15_000_000(), start
2019-02-01 06:24:31 +0000::roof20_000_000(), end
2019-02-01 06:24:33 +0000::roof15_000_000(), end
2019-02-01 06:24:33 +0000::dispatchGroup.notify OK
2019-02-01 06:24:33 +0000::dispatchGroupTestCase1Notify(), end

```

### case 2 (wait, synchronous)

```
2019-02-01 06:24:37 +0000::=====================
== synchronous
2019-02-01 06:24:37 +0000::dispatchGroupTestCase2Wait(), start
2019-02-01 06:24:37 +0000::roof20_000_000(), start
2019-02-01 06:24:37 +0000::roof10_000_000(), start
2019-02-01 06:24:40 +0000::roof10_000_000(), end
2019-02-01 06:24:40 +0000::roof15_000_000(), start
2019-02-01 06:24:43 +0000::roof20_000_000(), end
2019-02-01 06:24:45 +0000::roof15_000_000(), end
2019-02-01 06:24:45 +0000::dispatchGroup.wait OK(result::success)
2019-02-01 06:24:45 +0000::dispatchGroupTestCase2Wait(), end
```