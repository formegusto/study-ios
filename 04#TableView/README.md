# 04#TableView, Navigation Controller

## UITableView Overview

[Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uitableview)

iOS의 TableView는 단일 열에 세로로 스크롤되는 Contents들의 행을 표시한다. 하나의 행을 표시하도록 테이블을 구성하거나 관련 있는 행들을 모아 Section으로 Grouping하여 콘텐츠를 표시할 수 있다.

**[ 구성요소 ]**

- **Cells** : Contents에 해당하는 행들에 대한 시각적 표현을 제공한다.
- **Table view controller** : Tableview를 관리한다. UITableViewController를 통해 만들 수 있다.
- **Your data source object** : 테이블에 대한 데이터들을 제공한다. UITableViewDataSource Protocol을 구현하여 만들 수 있다.
- **Your delegate object** : 테이블에 대한 내용과 사용자 상호 작용을 관리한다. UITableViewDelegate Protocol을 구현하여 만들 수 있다.

## FullScreen Navigating and Storyboard Navigating Remind

```swift
@IBAction func moveToBasic(_ sender: Any) {
    let storyboard = UIStoryboard(name: "TableViewPractice", bundle: nil)
    let basicVC = storyboard.instantiateViewController(
					identifier: "TableViewPracticeViewController")
						as TableViewPracticeViewController
    basicVC.modalPresentationStyle = .fullScreen
    self.present(basicVC, animated: true, completion: nil)
}
```

- UIStoryboard 초기화에 사용되는 name은 어떤 ID 설정값이 아닌, Storyboard 파일 자체의 이름을 가리키고, instantiateViewController에 들어가는 identifier는 Storyboard 파일에 설정해준 ViewController의 Storyboard ID 이다.
- 위의 단계까지 완료되었다면, 조회한 ViewController에 modelPresentationStyle Property를 수정해줌으로, Navigation Animation Mode를 변경할 수 있다.

## UITableView Basic With Storyboard

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled.png)

TableView는 Cell을 관리하는 UITableView와 Cell을 나타내는 UITableViewCell이 있다.

**[ ReusableCell ]**

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%201.png)

Cell을 Table에 배치하는 방법은 재사용가능한 Cell로서 이용하는 것 이다. 이를 통해 알 수 있는 점은 iOS가 Component 혹은 Atom 단위의 UI Programming을 선호하는 것을 알 수가 있다. 재사용가능한 셀로서 불러올 수 있도록 TableViewCell Component에 ID를 설정해준다.

```swift
class TableViewPracticeViewController: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        myTable.dataSource = self
    }
}

extension TableViewPracticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }


}
```

Cell의 개수나 형태와 같은 설정은 UITableViewDataSource 에서 진행해준다. 많은 tableView 메서드들이 오버로딩되어져 있는데, 필수적으로 만들어야 할 것은 1) tableView 안에서의 cell 개수를 정의하는 numberOfRowInSection과 2) cell의 모양을 지정하는 cellForRowAt 매개변수를 가지는 tableView 메서드이다. 이 때, 방금 위에서 설정한 Reusable Cell Identifier가 dequeueResuableCell 메서드의 매개변수로 쓰인다. Protocol을 구현한 이후, UITableView의 dataSource와 protocol을 연결해준다.

**[ UITableViewDelegate ]** 테이블에 대한 사용자 상호작용을 적용한다. 대표적인 설정으로는 didSelectRowAt을 매개변수로 가지는 메서드이다. cell click 상호작용을 담당한다.

```swift
class TableViewPracticeViewController: UIViewController {
    override func viewDidLoad() {
        myTable.delegate = self
    }
}

extension TableViewPracticeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = items[indexPath.row]
        self.selectObserving.text = "selected cell : \(text)"
    }
}
```

**[ indexPath ]** 중첩 배열 트리의 특정 위치에 대한 경로를 나타낸다. 대충 배열적 특성을 가진 UI의 경로 특징을 나타낸다.

## UITableView Modularization with Nibs

**[ ProfileCell.xib ]**

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%202.png)

기본적인 Cell의 모양을 정의해준다.

**[ ProfileCell Register ]**

```swift
override func viewDidLoad() {
    let nib = UINib(nibName: "ProfileCell", bundle: nil)
    self.settingTableView.register(nib, forCellReuseIdentifier: "ProfileCell")
}
```

Storyboard 방식과 다르게, TableView에 종속된 Cell로서 선언된 것이 아니기 때문에 등록과정을 거쳐주어야 한다. 1) UIStoryboard 생성과 같게, 파일을 불러오는 방식인 UINib를 이용하여 Nib 파일을 불러와준다. 2) 이 후, reusableCell을 호출할 tableView에 종속되도록 등록과정을 진행해준다. 이 때 forCellReuseIdentifier에는 Cell의 Identifier가 입력되어야 한다.

**[ DataSource Definition ]**

```swift
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = self.settingTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        return profileCell
    }
}
```

이전 파트와 똑같은 방식으로 cellForRowAt 메서드에서 dequeueReusableCell 메서드를 이용해서 TableViewCell을 불러와준 후 리턴해주면 된다.

## Cell Height Config

```swift
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
				heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}
```

원래는 위와 같이 UITableViewDelegate에 heightForRowAt을 가지고 있는 메서드를 구현해줌으로써, Cell의 높이 지정을 해준다. 높이 지정을 해주지 않을 경우에는 셀 안에 컨텐츠 크기에 상관없이 기본값의 크기로 나타난다.

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%203.png)

하지만 셀에서 가장 큰 크기를 차지하고 있는 컨텐츠의 auto layout 기능을 사용해주면 자동으로 Cell 크기가 auto layout 설정에 의해 크기가 잡힌다. 하지만 이 또한 Delegate의 heightForRowAt의 설정에 따라 이루어지는 것 이다.

```swift
func tableView(_ tableView: UITableView,
			heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        default:
            return 48
    }
}
```

UITableView.automaticDimension은 자동으로 Cell의 크기를 잡는 설정이다. 이것이 기본값으로 잡혀져 있기 때문에 기본크기 혹은 auto layout 설정에 반응, 하게 되는 것 이다.

## Various Cell

```swift
func tableView(_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		var cell: UITableViewCell?
    if indexPath.row == 0 {
        cell = self.settingTableView.dequeueReusableCell(
									withIdentifier: "ProfileCell", for: indexPath)
    } else {
        cell = self.settingTableView.dequeueReusableCell(
									withIdentifier: "MenuCell", for: indexPath)
    }

    return cell!
}
```

다음과 같이 해주면 된다. indexPath가 가지고 있는 행 번호를 이용하여 cell 생성을 제어한다.

## Model

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%204.png)

Setting App의 구조를 보게되면, 아이콘 이미지, 제목, 그리고 chevron 으로 구성되어 있다.

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%205.png)

유사한 모양으로 Menu Cell을 구성해준다.

```swift
class Menu {
    let iconName: String
    let iconColor: UIColor
    let title: String

    init(_ iconName: String,_ iconColor: UIColor, _ title: String) {
        self.iconName = iconName
        self.iconColor = iconColor
        self.title = title
    }
}
```

개발자의 설정에 따라 반응해야 하는 icon wrapper의 바탕색, icon, 그리고 제목값으로 Menu Model을 구성해준다.

```swift
var menuStore: [[Menu]] = [
    [
			Menu("airplane", UIColor(red: 250 / 255, green: 129 / 255, blue: 2 / 255, alpha: 1), "에어플레인 모드"),
			// ...
    ],
    [
			Menu("bell.badge.fill", UIColor(red: 249 / 255, green: 35 / 255, blue: 37 / 255, alpha: 1), "알림"),
			// ...
    ]
]
```

Store를 구성해주고, indexPath.row, section 값을 잘 이용해서 테이블뷰에 배열한다.

## Navigation Controller

XCode는 기본적으로 Navigation Controller 생성을 지원해준다.

![Untitled](04#TableView,%20Navigation%20Controller%208d6b79e36aeb43dface2490a6490f58f/Untitled%206.png)

## Navigation Controller Header

```swift
self.title = "설정"
self.navigationController?.navigationBar.prefersLargeTitles = true
```

Embed In 에서 Navigation Controller를 설정해준 후, UIViewController의 title을 설정해주면 title header가 나타나게 된다. 그리고 header의 스타일을 설정해줄 수 있는데, 위와같이 설정할 경우 스크롤에 의해 반응하는 header를 만들 수 있다.

## Navigation Controller Navigate Features

Navigation Controller는 단일 앱에서 적절히 사용하기 위하여, 항상 최상위 Navigation으로 종속되도록 해야한다. 시작점은 info.plist 혹은 Storyboard마다 initial screen? 암튼 비슷한 속성있음! 그거 확인하면 된다.

**[ present ]**

```swift
@IBAction func moveToSetting(_ sender: Any) {
    let settingApp = UIStoryboard(name: "SettingApp", bundle: nil)
    let settingVC = settingApp.instantiateViewController(identifier: "SettingViewController") as SettingViewController

    let settingNC = UINavigationController(rootViewController: settingVC)
    settingNC.modalPresentationStyle = .fullScreen

    self.navigationController?.present(settingNC, animated: true, completion: nil)
}
```

이와 같이 Storyboard 상에서 서로 다른 Navigation Controller를 가지고 있을 때에 그냥 present 하면 Navigation Controller를 Embed 했을 때의 기능, Header와 같은 기능 등을 사용할 수 없다. 그렇기 때문에 UINavigation을 한번 감싸줘서 present 해주어야 한다.

**[ push ]**

```swift
let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
detailVC.title = menuStore[indexPath.section - 1][indexPath.row].title

self.navigationController?.pushViewController(detailVC, animated: true)
```

present는 새 창, 새 모달 등을 띄우는 기능인데, 여기에서 Push and pop 기능을 넣고싶다면 위와 같이 pushViewController를 이용해준다.

## Navigation Controller Style Guide

**[ Life Cycle Tips ]**

Navigation Controller는 다시 말하지만, 하나에 종속되는 개념이다. 그렇기 때문에 Style을 주게되면 모든 화면에서 지속되는 특징을 가지는데, viewDidLoad는 화면 LifeCycle에서 View들을 올릴 준비가 되었을 때, 딱 한번 실행된다. 그렇기 때문에 push 후, pop을 진행해도 viewDidLoad는 실행되지 않는다.

이 때는 viewWillAppear를 사용한다. viewWillAppear는 화면이 메인에 나타나기 전에 실행된다.

```swift
override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.prefersLargeTitles = true
}
```

**[ Right Bar Button Item ]**

```swift
let closeBtn = UIBarButtonItem(
		barButtonSystemItem: .close, target: self,
		action: #selector(prevBtnAction))
self.navigationItem.rightBarButtonItem = closeBtn
```

BackButton은 기본적으로 Navigation Controller에서 Push Action에 의해 화면에 나타나면 지원해주지만 Right Button은 직접 손봐주어야 한다. 이 때, UIBarButtonItem Component를 이용하며, 필요에 따라 CustomView eq.View Component로 Custom하게 만들 수 있다.

## Launch Screen

StoryBoard 중에 Launch Screen이 있다. 이 친구는 시작화면, Splash를 말한다. 근데 코드랑 연결할 수는 없다. 스타일만 지정해줄 수 있다.

## Etc. Style Guide

**[ Tableview Separate Style ]**

```swift
self.settingTableView.separatorStyle = .none
```

**[ TableView Section 간격 ]**

```swift
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(16)
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView()
    header.backgroundColor = .clear
    return header
}
```

header의 색을 투명하게 하고 header의 height를 지정해주면 된다. 혹은 Table View의 Style을 Grouped로 변경해주면 된다. Grouped가 더 좋은듯

**[ 부분 Border 설정 ]**

```swift
self.contentView.layer.cornerRadius = 12
self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
```

UIView의 layer프로퍼티의 maskedCorners를 이용한다. layer에 부분적으로 border radius를 설정할 수 있는 enum 변수들을 제공한다.
