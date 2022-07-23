# 05#GestureEvent

## UIKit Initializer

```swift
class DraggableView: UIView {
    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

UIKit에서 제공되는 View들도 일반 클래스와 같이 initiailze가 우선적으로 실행된다. 다른 점은 반드시 coder를 매개변수로 가지는 initializer를 구현해주어야 한다는 점 이다. 그리고 super.init()을 규격에 맞게 실행시켜줘야 한다.

**[ frame ]**

```swift
override init(frame: CGRect) {}
```

frame으로 view의 생김새를 받는다. 지정된 frame 형태로 view 객체를 초기화하고 반환한다.

**[ coder ]**

```swift
required init(coder: NSCoder) {}
```

unarchiver의 초기화된 객체를 반환한다. 여기서 unarchiving 이란, storyboard나 xib를 사용하게 되면 별도의 코딩 없이 앱의 속성을 수정할 수 있는데 이 과정을 말한다. 이들(Interface Builder)은 코딩에 의해 프로그래밍 되어지지 않았기 때문에 앱을 컴파일 하는 시점에 컴파일러가 인식할 수 있도록 코드로 변환해주는 unarchiving 과정이 필요하다. 이 과정에서 init(coder) 가 사용된다.

**[ coder usage ]**

```swift
required init?(coder: NSCoder) {
    super.init(coder: coder)

    let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
    self.addGestureRecognizer(pan)
}
```

아래 panGesture 기능을 xib로 추가한 것에 넣고 싶다면 frame이 아닌, coder를 매개변수로 갖는 init에 넣어 주어야 한다. 이와 같은 initializer가 있는 이유는 xib로의 생성 제한을 걸 수 있기 때문이다.

```swift
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

![Untitled](05#GestureEvent%203225f612fa7945c3ba9e19a024847c57/Untitled.png)

이와 같이 interface builder에 의해 생성되도록 하는 것에 제한을 둘 수 있다. 무조건 코드로 만들어라라는 의미로 사용할 수 있도록 가능!

## UIPanGestureRecognizer

```swift
init() {
    super.init(frame: CGRect.zero)

    let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
    self.addGestureRecognizer(pan)
}

@objc func dragging(pan: UIPanGestureRecognizer) {
    // Gesture Event에 반응하는 함수
}
```

사용자의 Gesture Event에 반응하는 View를 만드려면 UIPanGestureRegnizer를 생성하고, View에 등록(addGestureRecognizer)하는 과정을 거쳐야 한다.

## .state

```swift
switch pan.state {
    case .began:
        print("누르는 순간")
    case .changed:
        print("누르고 움직일 때")
    case .cancelled, .ended:
        print("누른 상태에서 그냥 멀리 이동하는 경우")
        print("그리고 끝났을 때")
        default:
            break
}
```

UIPanGestureRecognizer가 등록된 View를 클릭했을 때, 함께 등록된 이벤트 리스너가 실행되며, 매개변수로 전달되는 pan의 state 프로퍼티에는 현재 Gesture의 동작 상태값이 담겨져 있다.

## .translation

```swift
translation(in view: UIView?) -> CGPoint
```

pan의 translation에 무언가가 매개변수로 전달되면, 현재 사용자의 Gesture가 연결된 view를 기준으로 어디로 이동했는지에 대한 움직임 값을 반환한다. 현재 view가 아닌, 부모 view를 기준으로 하는 것이 현재 view에 대한 이동에 편리하다.

**[ 절대 좌표 ]**

```swift
var viewPosition = self.center
```

Gesture의 움직임만큼 view를 움직이기 위해서는 어떻게 해야할까? 현재 view의 중심점이 어디에 위치해 있는지 확인한 후, 움직임만큼 center 절대 좌표를 기준으로 움직이도록 하는 것이 편리할 것 이다. 이를 구하기 위해서는 self.center를 이용한다.

**[ translation initializing ]**

```swift
pan.setTranslation(CGPoint.zero, in: self.superview)
```

웹과는 다르게 position 값을 변화시켰을 때, Repaint 작업을 코드상에서 직접 진행해주어야 한다. UIPanGestureRecognizer는 setTranslation 메서드를 통해 이를 지원해준다. 첫 번째 매개변수는 기준값, 두 번째 매개변수는 기준을 얘기하는데, 우리는 지끔가지 superview를 기준으로 모든 것을 구해왔으니 위 처럼 진행해준다.

```swift
case .changed:
  let delta = pan.translation(in: self.superview)

  var viewPosition = self.center
  viewPosition.x += delta.x
  viewPosition.y += delta.y

  self.center = viewPosition
  pan.setTranslation(CGPoint.zero, in: self.superview)
```

## addSubView

```swift
let myView = DraggableView()
myView.center = self.view.center
myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
myView.backgroundColor = .red

self.view.addSubview(myView)
```

## Frame, Bounds Diff

```swift
extension UIView {
	open var frame: CGRect
	open var bounds: CGRect
}
```

UIView 에는 위치(origin)와 크기(size)를 나타내기 위한 CGRect를 사용하는 2개의 프로퍼티가 존재한다. frame과 bounds 이다.

**[ Frame ] : Super View 좌표계에서 View의 위치와 크기(View 영역을 모두 감싸는 사각형의 형태 ) 를 나타낸다.**

- View 영역을 모두 감싸는 사각형의 형태가 주가 되는데, 그렇기 때문에 Rotation 값이 변경된 Frame이 있다면, 해당 Frame의 frame.width or height 크기에 변화가 생긴다.

**[ Bounds ] : 자신의 좌표계에서 View의 위치와 크기를 나타낸다.**

- 자기 자신이 기준이기 때문에 origin은 항상 (0,0)으로 초기화 되어 있다. 그리고 Rotation 값이 변화해도 width height 에 변화가 없다.
- Origin의 사용 용도 : frame 에서의 origin은 변경 시키면 View 자체의 이동을 가능하게 해준다. 하지만 bound origin은 다른 의미를 가진다. View의 포지션 이동이 아닌, 현재 자신이 보고 있는 viewport 영역을 이동시키라는 뜻이 된다. 우리가 아는 일반적인 View의 포지션은 고정된 상태로 있는다. ( Scroll View의 원리가 이것이다. Viewport는 변경 시켜가는 것 )

## Segmented Control

![Untitled](05#GestureEvent%203225f612fa7945c3ba9e19a024847c57/Untitled%201.png)

**[ Action: Value Changed ]**

```swift
@IBAction func setXY(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
        self.dragType = .X
    case 1:
        self.dragType = .Y
    case 2:
        self.dragType = .none
    default:
        break
    }
}
```
