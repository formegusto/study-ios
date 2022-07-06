# 02#PassingData

## 데이터를 넘겨주는 방법

1. **Instance Property** : Instance에게 데이터를 넘겨주는 방법
2. **Segue** : 여러개의 ViewController가 하나의 Storyboard 상에 있을 때에 사용하는 방법
3. **Reverse Instance Property** : 이전 페이지에게 데이터를 넘겨주는 방법
4. **Delegate** : 대리, 위임의 Pattern 사용
5. **Closure** : Delegate와 유사개념
6. **Notification** : Delegate, Closure와 유사개념, 이 쯤에서 느낄 수 있는 것은 4,5,6은 모두 호출부와 Client가 따로 있다는 패턴에 기반한다.

## Instance Property

- **Cocoa Touch Class Config**

![Untitled](02#PassingData%20f790fd81fc154f18b6a2f7fdad2b556b/Untitled.png)

**[ XIB ]** iOS에서 Xib, Nib 라는 용어가 등장한다. 이들은 User Interface Field를 저장하기 위한 파일이다. Nib는 Binary 형태, Xib는 xml 형태를 띈다.

- **Instance Property Definition -** 넘어온 데이터를 받기 위한 instance property와 넘어온 데이터를 확인할 messageLabel를 연결해준다.

```swift
var message = ""
@IBOutlet weak var messageLabel: UILabel!
```

- **Instance Property Use** - 데이터를 넘겨담을 변수 instance property를 messageLabel에 연결한다.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    messageLabel.text = message
}
```

- **Navigation With Passing Data** - 이전에는 UIStoryboard를 통하여 storyboard객체를 생성하고, storyboard로부터 StoryboardID를 이용하여 ViewController를 가져와 present 했다. 이번에는 Xib를 사용하여 가져오는 방법을 소개한다.

```swift
let instancePropertyVC = InstancePropertyViewController(
															nibName: "InstancePropertyViewController",
															bundle: nil)
instancePropertyVC.message = "안녕하세요. 메인페이지 메시지 입니다."
self.present(instancePropertyVC, animated: true, completion: nil)
```

- **IBOutlet** - IBOutlet이라는 키워드의 변수는 화면 LifeCycle 중에서 화면에 view들을 올릴준비가 될 viewDidLoad 시점에 초기화가 완료되어있다. 그 전에는 nil 값을 가지고 있어 error가 발생한다.

```swift
// 아래와 같은 passing data는 진행하면 안된다.
instancePropertyVC.messageLabel.text = "안녕하세요. 메인페이지 메시지 입니다."
self.present(instancePropertyVC, animated: true, completion: nil)
```

## Segue

- **StoryBoard Setting** - 2개의 ViewController를 준비해준다.

![Untitled](02#PassingData%20f790fd81fc154f18b6a2f7fdad2b556b/Untitled%201.png)

- **Chaning ViewController** - Button을 ViewController에 Ctrl을 누른상태에서 연결해주면 Action Segue 란이 나타난다. Show를 눌러주면 present 기능이 연결된다.

![Untitled](02#PassingData%20f790fd81fc154f18b6a2f7fdad2b556b/Untitled%202.png)

- **Setting Segue Name** - 화살표를 눌러주면 identifier를 설정할 수 있는데, 설정해준다. 추가적으로 화살표는 여러개를 만들 수 있다.

![Untitled](02#PassingData%20f790fd81fc154f18b6a2f7fdad2b556b/Untitled%203.png)

- **prepare function** - ViewController로 부터 override 할 수 있는 prepare 함수는 segue가 동작할 때 호출되는 함수 이다.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
```

- **segue variable** - SegueViewController는 사전에 정의해서 새롭게 만든 ViewController에 연결해놓은 ViewController Class 이다. segue.identifier로 이전에 설정한 identifier를 확인할 수 있으며, 이후 데이터를 넘겨주는 방법은 segue.destination property가 내가 이동하려는 ViewController 로의 타입캐스팅이 되는지 if let 문법으로 확인하여 진행한다.

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "mySegue" {
        if let segueVC = segue.destination as? SegueViewController {
            segueVC.message = "안녕하세요. 세구에에 보냅니다."
        }
    }
}
```

## Reverse Instance Property

- **Instance Property Definition** - 다음 페이지로 넘어가는 것에 대한 제어는 현재 페이지에서 한다. 다음 페이지에서 자신을 제어할 수 있도록 자신에 대한 property(mainVC)를 정의해준다.

```swift
var mainVC: ViewController?
@IBOutlet weak var messageInput: UITextField!
```

- **Navigation With Instance Property**

```swift
let reverseInstanceVC = ReverseInstanceViewController(
							nibName: "ReverseInstanceViewController",
							bundle: nil)
reverseInstanceVC.mainVC = self
self.present(reverseInstanceVC, animated: true, completion: nil)
```

- **Control Prev Screen**

```swift
@IBAction func dismissWithMessage(_ sender: Any) {
    if mainVC != nil {
        mainVC!.mainMessage.text = messageInput.text ?? ""
    }
    self.dismiss(animated: true, completion: nil)
}
```

## Delegate

- **Protocol Delegate Definition** - delegation pattern은 실행의 권한을 위임하는 방법이다. protocol을 사용한 delegation pattern은 규격을 정의만 해놓을 뿐, 기능의 구현은 사용하는 Class 쪽에서 진행해주어야 한다. 이와 같은 경우에는 DelegateViewControllerDelegate를 상속받아 passString을 구현할 경우, passString에 DelegateViewController로 부터 입력된 텍스트필드의 값을 받아볼 수 있다. 그리고 본인의 instance 쪽, 화면 에서 처리할 수 있다.

```swift
protocol DelegateViewControllerDelegate: AnyObject {
    func passString(string: String) -> Void
}

class DelegateViewController: ViewController {
    weak var delegate: DelegateViewControllerDelegate?
		// ...
		@IBAction func dismissWithMessage(_ sender: Any) {
        if delegate != nil {
            let passMessage = messageInput.text ?? ""
            delegate?.passString(string: passMessage)
        }

        self.dismiss(animated: true, completion: nil)
    }
}
```

- **Client - Delegate Inheritance** - delegate protocol을 상속받아 passString을 구현해준다.

```swift
extension ViewController: DelegateViewControllerDelegate {
    func passString(string: String) {
        self.mainMessage.text = string
    }
}
```

- **Client - Delegate Use** - 사용법은 간단하다. DelegateViewController의 delegate에 자신을 대입해주면 된다.

```swift
let delegateVC = DelegateViewController(
												nibName: "DelegateViewController",
												bundle: nil)
delegateVC.delegate = self
self.present(delegateVC, animated: true)
```

**Delegation Pattern은 후에 많은 Swift UiKit 에서 사용이 된다. 잘 이해하고 있는 것이 좋다.**

## Closure

- **Closure Definition** - Delegate Pattern과 비슷한 점은 사용을 필요로 한다면 구현을 하여 위임하기를 선택할 수 있다는 점 이다. Optional로 선언해준다.

```swift
var myClosure: ((_ msg:String) -> Void)?
```

- **Delegate - Closure Callback**

```swift
@IBAction func dismissWithSend(_ sender: Any) {
    let _msg = self.msgInput.text ?? ""
    myClosure?(_msg)
    self.dismiss(animated: true, completion: nil)
}
```

- **Client - Closure Use**

```swift
let closureVC = ClosureViewController(
											nibName: "ClosureViewController",
											bundle: nil)
closureVC.myClosure = { self.mainMessage.text = $0 }
self.present(closureVC, animated: true, completion: nil)
```

## Notification

- **NotificationName Definition** - 후에 다른 화면에서 notificationName을 통해 notification을 Observe하고 있는 화면에 이벤트를 넘겨주는 작업을 진행할 것 이다. NotificationName 을 정의해준 후, addObserver로 NotificationName을 등록해준다.

```swift
let notificationName = Notification.Name("send msg from notification")
NotificationCenter.default.addObserver(
							self, selector: #selector(receiveFromNotification),
							name: notificationName, object: nil)
```

addObserver는 중복 체크를 진행하지 않는다. 작성한 만큼 추가된다.

- **Notification Selector Function** - NotificationCenter.default.addObserver의 인자 중 하나인 #selector()에 들어가는 함수에는 @objc 키워드를 붙인 함수가 따라와야 한다. 이는 간단히 Runtime 때 Swift가 Objective-C와 상호작용해야 할때 사용한다. 해당 Notification이 발생했을 때, 해당 함수가 실행된다.

```swift
@objc func receiveFromNotification(notification: Notification) {
    if let str = notification.userInfo?["msg"] as? String {
        self.mainMessage?.text = str
    }
}
```

notification은 userInfo라는 Dictionary 형태의 컬렉션으로 상호작용한다.

- **Notification Use** - 똑같이 notificationName을 정의해준 이후에, 해당 Notification으로 userInfo를 발생시킨다.

```swift
let notificationName = Notification.Name("send msg from notification")
NotificationCenter.default.post(
				name: notificationName,
				object: nil,
				userInfo: ["msg": msgInput.text ?? ""])
self.dismiss(animated: true, completion: nil)
```

- **Notification With iOS UI** - Notification은 사용자 정의스럽게 말고도 시스템 동작에 따라 반응할 수도 있다. UIResponder 에는 iOS 운영체제의 UI관련한 Notification Name들이 정의되어 있다.

```swift
NotificationCenter.default.addObserver(
						self, selector: #selector(keyboardWillShow),
						name: UIResponder.keyboardWillShowNotification,
						object: nil)
```

- **Remove** - 상황에 따라 삭제해야할 경우 사용한다.

```swift
NotificationCenter.default.removeObserver(
					self, name: notificationName, object: nil)
```
