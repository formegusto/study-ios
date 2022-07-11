# 03#Dispatch Queue

> **Thread를 여러개 만들어 관리하는 개념**

## Main Thread

iOS System에서 Main Thread는 전체적인 App, Component들의 구성요소의 Life Cycle을 관리하며, 주 역할은 UI 갱신의 역할을 한다. 프로세스에 단 하나의 쓰레드로서 존재한다.

```swift
Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {timer in
    self.timerLabel.text = Date().timeIntervalSince1970.description
})
```

다음과 같이 mainThread에 주기적으로 동작하는 Timer 함수를 실행시켜놨을 때, 아래와 같이 일반적으로 코드로 이벤트 처리를 진행하고, 이벤트가 실행되었을 때, main thread에 2개의 작업이 준비상태에 들어가게 되는 것 이다.

```swift
@IBAction func actionOne(_ sender: Any) {
  finishLabel.text = "끝"
}
```

그러면 actionOne이라는 이벤트 처리 함수가 종료되기 전까지 mainThread에서 주기적으로 동작하는 Timer함수의 UI 갱신은 이루어지지 않게 된다. actionOne에 네트워크, I/O 작업과 같은 작업 시간이 오래걸리는 작업이 있다면 오랫동안 Timer의 UI갱신은 멈춰있게 될 것 이다. mainThread는 이렇듯 하나의 Thread로서의 스케줄링 작업을 한다.

## Dispatch Queue For Multi-Threading

```swift
@IBAction func actionOne(_ sender: Any) {
    simpleClosure {
        DispatchQueue.main.async {
            self.finishLabel.text = "끝"
        }
    }
}

func simpleClosure(_ completion: @escaping () -> Void) {
    DispatchQueue.global().async {
      for index in 0..<10 {
          Thread.sleep(forTimeInterval: 0.2)
          print(index)
      }
			completion()
		}
}
```

**[ DispatchQueue.global().async ]** 1회성 thread를 생성하고, 작업을 실행한다. 이 때 생성된 thread는 sync 방식과, async 방식을 택할 수 있는데 async인 경우 실행 상에서 새로운 thread에게 실행을 위임만 해주고 main thread는 계속해서 진행이 된다.

**[ DispatchQueue.main.async ]** UI의 갱신은 main thread에서만 진행해야 한다. 이는 UI 갱신의 순서보장을 위함이다.

**[ escaping closure ]** 인자로 전달되는 클로저가 함수가 종료된 뒤에도 실행되면 이를 escaping closure라고 부른다. async 키워드로 생성된 thread는 함수가 종료된 후에도 계속 실행되며 긴 작업이 끝난 후에도 completion 클로저를 실행시켜야 하는 의무가 있다. @escaping 키워드를 꼭 붙여서 전달해주어야 한다.

## Custom Dispatch Queue

```swift
let queue1 = DispatchQueue(label: "q1")
let queue2 = DispatchQueue(label: "q2")

queue1.async {
  for index in 10..<20 {
      Thread.sleep(forTimeInterval: 0.2)
      print(index)
  }
}
queue1.async {
	for index in 20..<30 {
		Thread.sleep(forTimeInterval: 0.2)
		print(index)
	}
}
queue2.async {
	for index in 30..<40 {
      Thread.sleep(forTimeInterval: 0.2)
      print(index)
  }
}
```

1회성이 아닌, 여러개의 queue를 생성해서 여러 작업을 비동기적으로 진행시킬 수 있다. 하지만 queue1의 두번째 작업 같은 경우에는 첫 번째 작업이 끝나고 나서야 진행이 된다. queue1에는 두 가지의 작업이 올라가 있는 셈이기 때문이다.

## DispatchGroup

```swift
let dispatchGroup = DispatchGroup()

queue1.async(group: dispatchGroup){
    for index in 10..<20 {
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}
queue2.async(group: dispatchGroup) {
    for index in 20..<30 {
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    print("끝")
}
```

dispatchQueue 들을 Group으로 묶어서 이들의 종료시점을 Observing 할 수 있다.

## Nested DispatchQueue Management

```swift
queue1.async(group: dispatchGroup){
    for index in 10..<20 {
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
    DispatchQueue.global().async {
        for index in 40..<50 {
            Thread.sleep(forTimeInterval: 0.2)
            print(index)
        }
    }
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    print("끝")
}
```

위와 같은 경우 queue1은 dispatchGroup에 의해 관리되어지고 있지만 그 안에 중첩으로 생성된 thread인 DispatchQueue.global().async는 dispatchGroup에 의해 관리되지 않는다. async이기도 해서 queue1의 작업이 끝나는 동시에 종료시점 함수가 실행된다.

이런 경우에는 수동적으로 입장시점과 퇴장시점을 지정해줘서 해결할 수 있다.

```swift
dispatchGroup.enter()
DispatchQueue.global().async {
    for index in 40..<50 {
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
    dispatchGroup.leave()
}
```

## Sync DispatchQueue

```swift
queue1.sync {
    for index in 0..<10{
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}
queue2.sync {
    for index in 10..<20{
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}
```

Dispatch Queue는 2가지의 옵션이 있다고 했다. sync는 평상시 비동기 프로그래밍을 해봤으면 알다시피 작업이 끝나기 전까지 다음 코드를 실행시키지 않는다. iOS에서도 마찬가지이다.

**[ main thread sync with dead lock ]**

교착상태 (dead lock)이란 자원할당을 무한정 기다려 프로그램이 죽어버리는 현상을 나타낸다.

```swift
queue1.sync {
    for index in 0..<10{
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
    queue1.sync {
        for index in 10..<20{
            Thread.sleep(forTimeInterval: 0.2)
            print(index)
        }
    }
}
```

위 코드는 iOS에서 무조건적으로 dead lock이 발생할 수 있도록 하는 코드이다. 상위 queue1이 끝나야 하위 queue1이 실행되는데, 상위 queue1은 하위 queue1이 끝나야 끝나게 된다. 무한정 대기 상태에 들어간다.

```swift
DispatchQueue.main.sync {
	print("main sync")
}
```

main thread에서 sync를 사용하면 바로 위와같은 원리가 되어버린다. main thread는 timer 예시에서도 봤다시피 하나의 thread 안에서 동기적으로 작동한다. 그렇기 때문에 다음과 같은 코드를 작성할 경우 main thread가 main thread를 기대리는 circular wait 상태에 빠지게 됨으로 dead lock이 발생한다. main thread는 거의 무조건적으로 동작하고 있기 때문이다.

## QoS (Quality of Service)

Dispatch Queue Async에 우선순위를 정해줄 수 있다.

```swift
public struct DispatchQoS : Equatable {

    public let qosClass: DispatchQoS.QoSClass

    public let relativePriority: Int

    @available(macOS 10.10, iOS 8.0, *)
    public static let background: DispatchQoS

    @available(macOS 10.10, iOS 8.0, *)
    public static let utility: DispatchQoS

    @available(macOS 10.10, iOS 8.0, *)
    public static let `default`: DispatchQoS

    @available(macOS 10.10, iOS 8.0, *)
    public static let userInitiated: DispatchQoS

    @available(macOS 10.10, iOS 8.0, *)
    public static let userInteractive: DispatchQoS

    public static let unspecified: DispatchQoS
		// ...
}
```

background 부터 userInteractive 까지 우선순위를 나타내며 뒤로 갈 수록 높은 우선순위를 가진다. unspecified는 시스템에서 추론하여 우선순위를 부여하는 변수이다.

```swift
queue1.async(group: dispatchGroup, qos: .background) {
    for index in 0..<10{
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}

queue2.async(group: dispatchGroup, qos: .userInteractive) {
    for index in 10..<20{
        Thread.sleep(forTimeInterval: 0.2)
        print(index)
    }
}
```

다음과 같이 코드를 작성하면 queue1의 작업과 queue2의 작업이 동시적으로 준비상태 큐에 있을 때, queue2의 작업이 우선적으로 실행된다. 하지만 어떤 queue의 작업이 먼저 들어올지 모르기 때문에 절대적인 순서보장은 되지 않는다. 단지 반응이 빠른 작업, 느린 작업을 구분하게 할 수 있다.
