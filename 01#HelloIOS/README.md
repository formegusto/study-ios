# 01#StartIOS

## Create Project 👋

**[ 1. XCode 실행, Create a new Xcode project Click or File → New → Project ]**

**[ 2. Tab iOS → App Click ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled.png)

iOS는 iPhone, iPad 관련하여 개발을 진행할 수 있다.

**[ 3. Project Information ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%201.png)

- Product Name : Project Name, Company Name 등이 들어간다.
- Bundle Identifier : SwiftUI (iOS 13 버전 이후에 나타남. 화면 구성 방식이 Storyboard와 완전히 다르다.)
- Language : Swift

**[ 4. Save! ]**

## Project Information

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%202.png)

**[ General ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%203.png)

- Bundle Identifer : App 이 가진 고유의 id, 회사의 주소를 반대로 적기도 한다. 나중에 Store에 등록할 때 반드시 고유한 id를 가지고 있어야 한다.

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%204.png)

- iOS 15.5 : 수정이 가능, App이 iPhone 전용인지 iPad 전용인지 구분할 수 있다. 버전이 뜻하는 것은 iOS 몇 버전 이상부터 해당 App을 지원할 것인지를 나타낸다. 보통 2단계 정도 낮추어서 개발한다. ( 사용자를 늘리는 방법 중 하나, 은행같은 시스템은 옛날 iOS를 지원하기도 한다. ) 너무 낮추면 많은 작업을 추가로 진행해줘야 한다.

## File Structure

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%205.png)

- AppDelegate.swift : 가장 기본이 되는 시작점, Main, App의 Life Cycle을 관리한다.
- SceneDelegate.swift : 예전에는 AppDelegate에 들어있던 일부 기능이 분리되었다. 그렇기 때문에 AppDelegate의 특징 중 하나인 Life Cycle 관련 함수를 확인할 수 있다.
- ViewController.swift : 화면의 시작점이다.
- Main.Storyboard : ViewController.swift와 기본적으로 연결이 되어있다. View Controller가 시작점이 되는 이유는 위에 Project 정보의 Main Interface를 보면 자신과 연결되어 있는 Main Storyboard로 설정되어 있기 때문, 또한 시작되는 ViewController는 Storyboard에서 ViewController를 선택해주면 is Initial View Controller에 체크가 되어있는 것을 확인할 수 있다.

## Storyboard

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%206.png)

GUI 환경에서 UI 개발 작업을 진행한다.

## Storyboard With Code

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%207.png)

Storyboard 에서 개발한 View가 기능을 하게 만들려면 코드와 연결이 되어야 한다. 현재 ViewController.swift와 Main Storyboard의 시작 ViewController View와 연결이 되어 있는 것을 확인할 수 있다.

**[ Ctrl + 마우스 드래그 ]** 특정 View를 선택한 상태에서 코드쪽으로 Drag 해주면 해당 View를 Object로 혹은 Action을 추가 등의 작업을 할 수 있다.

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%208.png)

**[ Outlet ]**

```swift
@IBOutlet weak var testButton: UIButton!
```

- weak 는 ARC를 통해 메모리 관리를 하는 Swift의 메모리 누수를 방지하기 위한 키워드이다. 참조하고 있는 변수가 참조를 해제하면 weak 변수도 참조를 해제한다.
- @IBOutlet 은 화면이랑 연결되어 있는 변수를 가리킨다.

```swift
@IBOutlet weak var testButton: UIButton!
override func viewDidLoad() {
    super.viewDidLoad()

    testButton.backgroundColor = .red
}
```

“**ctrl + R을 누르면 실행시킬 수 있다.”**

**[ Action ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%209.png)

Action 을 생성하는 과정에서는 해당 아웃렛의 이벤트 리스너 타입들이 나타난다. 기본적으로 버튼에는 Touch Up Inside를 사용한다.

```swift
@IBAction func doSomething(_ sender: Any) {
    testButton.backgroundColor = .orange
}
```

## Inheritance

```swift
class ViewController: UIViewController
```

Swift의 기본적인 View Widget들은 UIKit에 정의되어 있는 Class들을 상속받아 사용한다.

## Move Screen

**[ 1. Cocoa Touch Class 선택 ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%2010.png)

**[ 2. 일단 생성 ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%2011.png)

**[ 3. 화면과 방금 생성한 DetailVC를 연결해준다. ]**

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%2012.png)

**[ 4. Coding! ]**

화면이랑 연결되어 있는 Class 이기 때문에 그냥 만들면 안된다. 그래서 보통 인스턴스화랑은 다른 개념이다. UIStoryboard 클래스를 이용하여 가져오도록 한다.

```swift
UIStoryboard(name:, bundle:)
```

여기서 UIStoryboard 에 보내주는 매개변수 중에 name이라고 있는데 이것도 설정해주어야 한다. 어떤 storyboard를 가지고올 것인지에 대한 설정이다. 여기에는 storyboard 이름을 넣어주면 된다.

![Untitled](01#StartIOS%20223b6ecb2fb7492d8aba0c27f668bf52/Untitled%2013.png)

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let detailVC = storyboard.instantiateViewController(
			identifier: "Detail") as DetailVC

self.present(detailVC, animated: true, completion: nil)
```

storyboard 객체의 instantiateViewController 를 실랭하면 ViewController 객체를 반환한다. 이 때 identifier에는 ViewController에 지정해준 StoryboardID를 입력하여 가져온다. 추가적으로 Casting 까지 진행해준다.

## LifeCycle Basic

| Function          | Timing                                |
| ----------------- | ------------------------------------- |
| viewDidLoad       | 화면에 View들을 띄울 준비가 되었을 때 |
| viewWillAppear    | 화면에 View들을 그리기 직전           |
| viewDidAppear     | 화면에 View들을 그린 후               |
| viewWillDisappear | 화면이 사라지기 직전                  |
| viewDidDisappear  | 화면이 사라진 후                      |
