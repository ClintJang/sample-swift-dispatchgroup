# Swift Dispatchgroup Sample
It is a repository showing a simple example using "DispatchGroup". <br />
Jobs already in group via DispatchGroup
Wait for it to finish and use it when you expect it to be called when it's all done.

- "notify" works asynchronously.
- "wait" works synchronously.
- "queue, notify" works synchronously

## Result Image (GIF)
<img width="500" src="/Image/resultInfo00.gif">

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

## Case 03 (queue, notify)
> asynchronous, Do not use enter and leave.

```swift
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
```

## Result Log

### case 1 (notify, asynchronous)

```
2019-02-01 08:15:42 +0000::=====================
== asynchronous
2019-02-01 08:15:42 +0000::dispatchGroupTestCase1Notify(), start
2019-02-01 08:15:42 +0000::roof20_000_000(), start
2019-02-01 08:15:42 +0000::roof15_000_000(), start
2019-02-01 08:15:42 +0000::roof10_000_000(), start
2019-02-01 08:15:45 +0000::roof10_000_000(), end
2019-02-01 08:15:47 +0000::roof15_000_000(), end
2019-02-01 08:15:48 +0000::roof20_000_000(), end
2019-02-01 08:15:48 +0000::dispatchGroup.notify OK
2019-02-01 08:15:48 +0000::dispatchGroupTestCase1Notify(), end

```

### case 2 (wait, synchronous)

```
2019-02-01 08:15:49 +0000::=====================
== synchronous
2019-02-01 08:15:49 +0000::dispatchGroupTestCase2Wait(), start
2019-02-01 08:15:49 +0000::roof20_000_000(), start
2019-02-01 08:15:49 +0000::roof10_000_000(), start
2019-02-01 08:15:49 +0000::roof15_000_000(), start
2019-02-01 08:15:52 +0000::roof10_000_000(), end
2019-02-01 08:15:54 +0000::roof15_000_000(), end
2019-02-01 08:15:55 +0000::roof20_000_000(), end
2019-02-01 08:15:55 +0000::dispatchGroup.wait OK(result::success)
2019-02-01 08:15:55 +0000::dispatchGroupTestCase2Wait(), end
```

### case 3 (queue, notify, asynchronous)

```
2019-02-01 08:15:57 +0000::=====================
== asynchronous
2019-02-01 08:15:57 +0000::=====================
== Do not use enter and leave.
2019-02-01 08:15:57 +0000::dispatchGroupTestCase3QueueNotify(), start
2019-02-01 08:15:57 +0000::roof20_000_000(), start
2019-02-01 08:15:57 +0000::roof15_000_000(), start
2019-02-01 08:15:57 +0000::roof10_000_000(), start
2019-02-01 08:16:00 +0000::roof10_000_000(), end
2019-02-01 08:16:01 +0000::roof15_000_000(), end
2019-02-01 08:16:03 +0000::roof20_000_000(), end
2019-02-01 08:16:03 +0000::dispatchGroup.notify OK
2019-02-01 08:16:03 +0000::dispatchGroupTestCase3QueueNotify(), end
```
