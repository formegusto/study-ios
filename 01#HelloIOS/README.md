# 01#StartIOS

## Create Project ๐

**[ 1. XCode ์คํ, Create a new Xcode project Click or File โ New โ Project ]**

**[ 2. Tab iOS โ App Click ]**

<img width="1512" alt="Untitled" src="https://user-images.githubusercontent.com/52296323/176862123-0473c143-c1aa-4fb9-9b2a-c4ca00558605.png">

iOS๋ iPhone, iPad ๊ด๋ จํ์ฌ ๊ฐ๋ฐ์ ์งํํ  ์ ์๋ค.

**[ 3. Project Information ]**

<img width="1512" alt="Untitled 1" src="https://user-images.githubusercontent.com/52296323/176862140-4142a644-9480-43a1-b90c-f23361e2322e.png">

- Product Name : Project Name, Company Name ๋ฑ์ด ๋ค์ด๊ฐ๋ค.
- Bundle Identifier : SwiftUI (iOS 13 ๋ฒ์  ์ดํ์ ๋ํ๋จ. ํ๋ฉด ๊ตฌ์ฑ ๋ฐฉ์์ด Storyboard์ ์์ ํ ๋ค๋ฅด๋ค.)
- Language : Swift

**[ 4. Save! ]**

## Project Information

<img width="1468" alt="Untitled 2" src="https://user-images.githubusercontent.com/52296323/176862172-89e8704f-9a16-428c-8b7c-d08bb7823d8e.png">

**[ General ]**

<img width="687" alt="Untitled 3" src="https://user-images.githubusercontent.com/52296323/176862175-03af87a9-aa56-4b35-8ab3-dda41ab52d6c.png">

- Bundle Identifer : App ์ด ๊ฐ์ง ๊ณ ์ ์ id, ํ์ฌ์ ์ฃผ์๋ฅผ ๋ฐ๋๋ก ์ ๊ธฐ๋ ํ๋ค. ๋์ค์ Store์ ๋ฑ๋กํ  ๋ ๋ฐ๋์ ๊ณ ์ ํ id๋ฅผ ๊ฐ์ง๊ณ  ์์ด์ผ ํ๋ค.

<img width="689" alt="Untitled 4" src="https://user-images.githubusercontent.com/52296323/176862251-9a87b48a-ddb8-45f5-b56b-f11aa54668f4.png">

- iOS 15.5 : ์์ ์ด ๊ฐ๋ฅ, App์ด iPhone ์ ์ฉ์ธ์ง iPad ์ ์ฉ์ธ์ง ๊ตฌ๋ถํ  ์ ์๋ค. ๋ฒ์ ์ด ๋ปํ๋ ๊ฒ์ iOS ๋ช ๋ฒ์  ์ด์๋ถํฐ ํด๋น App์ ์ง์ํ  ๊ฒ์ธ์ง๋ฅผ ๋ํ๋ธ๋ค. ๋ณดํต 2๋จ๊ณ ์ ๋ ๋ฎ์ถ์ด์ ๊ฐ๋ฐํ๋ค. ( ์ฌ์ฉ์๋ฅผ ๋๋ฆฌ๋ ๋ฐฉ๋ฒ ์ค ํ๋, ์ํ๊ฐ์ ์์คํ์ ์๋  iOS๋ฅผ ์ง์ํ๊ธฐ๋ ํ๋ค. ) ๋๋ฌด ๋ฎ์ถ๋ฉด ๋ง์ ์์์ ์ถ๊ฐ๋ก ์งํํด์ค์ผ ํ๋ค.

## File Structure

<img width="265" alt="Untitled 5" src="https://user-images.githubusercontent.com/52296323/176862265-1315c879-febe-4fd7-8f3f-70517c28a25e.png">

- AppDelegate.swift : ๊ฐ์ฅ ๊ธฐ๋ณธ์ด ๋๋ ์์์ , Main, App์ Life Cycle์ ๊ด๋ฆฌํ๋ค.
- SceneDelegate.swift : ์์ ์๋ AppDelegate์ ๋ค์ด์๋ ์ผ๋ถ ๊ธฐ๋ฅ์ด ๋ถ๋ฆฌ๋์๋ค. ๊ทธ๋ ๊ธฐ ๋๋ฌธ์ AppDelegate์ ํน์ง ์ค ํ๋์ธ Life Cycle ๊ด๋ จ ํจ์๋ฅผ ํ์ธํ  ์ ์๋ค.
- ViewController.swift : ํ๋ฉด์ ์์์ ์ด๋ค.
- Main.Storyboard : ViewController.swift์ ๊ธฐ๋ณธ์ ์ผ๋ก ์ฐ๊ฒฐ์ด ๋์ด์๋ค. View Controller๊ฐ ์์์ ์ด ๋๋ ์ด์ ๋ ์์ Project ์ ๋ณด์ Main Interface๋ฅผ ๋ณด๋ฉด ์์ ๊ณผ ์ฐ๊ฒฐ๋์ด ์๋ Main Storyboard๋ก ์ค์ ๋์ด ์๊ธฐ ๋๋ฌธ, ๋ํ ์์๋๋ ViewController๋ Storyboard์์ ViewController๋ฅผ ์ ํํด์ฃผ๋ฉด is Initial View Controller์ ์ฒดํฌ๊ฐ ๋์ด์๋ ๊ฒ์ ํ์ธํ  ์ ์๋ค.

## Storyboard

<img width="1680" alt="Untitled 6" src="https://user-images.githubusercontent.com/52296323/176862280-fda4602a-f8e7-4a48-bb97-0e8f47eeba02.png">

GUI ํ๊ฒฝ์์ UI ๊ฐ๋ฐ ์์์ ์งํํ๋ค.

## Storyboard With Code

<img width="926" alt="Untitled 7" src="https://user-images.githubusercontent.com/52296323/176862302-fc7c4316-efdb-4e90-bb63-21ad7e30d7fc.png">

Storyboard ์์ ๊ฐ๋ฐํ View๊ฐ ๊ธฐ๋ฅ์ ํ๊ฒ ๋ง๋ค๋ ค๋ฉด ์ฝ๋์ ์ฐ๊ฒฐ์ด ๋์ด์ผ ํ๋ค. ํ์ฌ ViewController.swift์ Main Storyboard์ ์์ ViewController View์ ์ฐ๊ฒฐ์ด ๋์ด ์๋ ๊ฒ์ ํ์ธํ  ์ ์๋ค.

**[ Ctrl + ๋ง์ฐ์ค ๋๋๊ทธ ]** ํน์  View๋ฅผ ์ ํํ ์ํ์์ ์ฝ๋์ชฝ์ผ๋ก Drag ํด์ฃผ๋ฉด ํด๋น View๋ฅผ Object๋ก ํน์ Action์ ์ถ๊ฐ ๋ฑ์ ์์์ ํ  ์ ์๋ค.

<img width="715" alt="Untitled 8" src="https://user-images.githubusercontent.com/52296323/176862318-ed9f6786-dffb-43f7-b6ab-d9ce6d191de8.png">

**[ Outlet ]**

```swift
@IBOutlet weak var testButton: UIButton!
```

- weak ๋ ARC๋ฅผ ํตํด ๋ฉ๋ชจ๋ฆฌ ๊ด๋ฆฌ๋ฅผ ํ๋ Swift์ ๋ฉ๋ชจ๋ฆฌ ๋์๋ฅผ ๋ฐฉ์งํ๊ธฐ ์ํ ํค์๋์ด๋ค. ์ฐธ์กฐํ๊ณ  ์๋ ๋ณ์๊ฐ ์ฐธ์กฐ๋ฅผ ํด์ ํ๋ฉด weak ๋ณ์๋ ์ฐธ์กฐ๋ฅผ ํด์ ํ๋ค.
- @IBOutlet ์ ํ๋ฉด์ด๋ ์ฐ๊ฒฐ๋์ด ์๋ ๋ณ์๋ฅผ ๊ฐ๋ฆฌํจ๋ค.

```swift
@IBOutlet weak var testButton: UIButton!
override func viewDidLoad() {
    super.viewDidLoad()

    testButton.backgroundColor = .red
}
```

โ**ctrl + R์ ๋๋ฅด๋ฉด ์คํ์ํฌ ์ ์๋ค.โ**

**[ Action ]**

<img width="586" alt="Untitled 9" src="https://user-images.githubusercontent.com/52296323/176862330-0275effe-24d0-4ebd-86f9-998ba94f4c48.png">

Action ์ ์์ฑํ๋ ๊ณผ์ ์์๋ ํด๋น ์์๋ ์ ์ด๋ฒคํธ ๋ฆฌ์ค๋ ํ์๋ค์ด ๋ํ๋๋ค. ๊ธฐ๋ณธ์ ์ผ๋ก ๋ฒํผ์๋ Touch Up Inside๋ฅผ ์ฌ์ฉํ๋ค.

```swift
@IBAction func doSomething(_ sender: Any) {
    testButton.backgroundColor = .orange
}
```

## Inheritance

```swift
class ViewController: UIViewController
```

Swift์ ๊ธฐ๋ณธ์ ์ธ View Widget๋ค์ UIKit์ ์ ์๋์ด ์๋ Class๋ค์ ์์๋ฐ์ ์ฌ์ฉํ๋ค.

## Move Screen

**[ 1. Cocoa Touch Class ์ ํ ]**

<img width="1680" alt="Untitled 10" src="https://user-images.githubusercontent.com/52296323/176862344-2dfa9d0b-6523-430b-bf11-2bf946a4be2f.png">

**[ 2. ์ผ๋จ ์์ฑ ]**

<img width="1680" alt="Untitled 11" src="https://user-images.githubusercontent.com/52296323/176862362-01042738-2136-461d-aad6-916c55940221.png">

**[ 3. ํ๋ฉด๊ณผ ๋ฐฉ๊ธ ์์ฑํ DetailVC๋ฅผ ์ฐ๊ฒฐํด์ค๋ค. ]**

<img width="475" alt="Untitled 12" src="https://user-images.githubusercontent.com/52296323/176862373-36473b9e-c5bf-4f63-ac5d-cb3609195bea.png">

**[ 4. Coding! ]**

ํ๋ฉด์ด๋ ์ฐ๊ฒฐ๋์ด ์๋ Class ์ด๊ธฐ ๋๋ฌธ์ ๊ทธ๋ฅ ๋ง๋ค๋ฉด ์๋๋ค. ๊ทธ๋์ ๋ณดํต ์ธ์คํด์คํ๋์ ๋ค๋ฅธ ๊ฐ๋์ด๋ค. UIStoryboard ํด๋์ค๋ฅผ ์ด์ฉํ์ฌ ๊ฐ์ ธ์ค๋๋ก ํ๋ค.

```swift
UIStoryboard(name:, bundle:)
```

์ฌ๊ธฐ์ UIStoryboard ์ ๋ณด๋ด์ฃผ๋ ๋งค๊ฐ๋ณ์ ์ค์ name์ด๋ผ๊ณ  ์๋๋ฐ ์ด๊ฒ๋ ์ค์ ํด์ฃผ์ด์ผ ํ๋ค. ์ด๋ค storyboard๋ฅผ ๊ฐ์ง๊ณ ์ฌ ๊ฒ์ธ์ง์ ๋ํ ์ค์ ์ด๋ค. ์ฌ๊ธฐ์๋ storyboard ์ด๋ฆ์ ๋ฃ์ด์ฃผ๋ฉด ๋๋ค.

<img width="511" alt="Untitled 13" src="https://user-images.githubusercontent.com/52296323/176862389-abdaee8e-a180-42ea-b81a-acd010700095.png">

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let detailVC = storyboard.instantiateViewController(
			identifier: "Detail") as DetailVC

self.present(detailVC, animated: true, completion: nil)
```

storyboard ๊ฐ์ฒด์ instantiateViewController ๋ฅผ ์ค๋ญํ๋ฉด ViewController ๊ฐ์ฒด๋ฅผ ๋ฐํํ๋ค. ์ด ๋ identifier์๋ ViewController์ ์ง์ ํด์ค StoryboardID๋ฅผ ์๋ ฅํ์ฌ ๊ฐ์ ธ์จ๋ค. ์ถ๊ฐ์ ์ผ๋ก Casting ๊น์ง ์งํํด์ค๋ค.

## LifeCycle Basic

| Function          | Timing                                |
| ----------------- | ------------------------------------- |
| viewDidLoad       | ํ๋ฉด์ View๋ค์ ๋์ธ ์ค๋น๊ฐ ๋์์ ๋ |
| viewWillAppear    | ํ๋ฉด์ View๋ค์ ๊ทธ๋ฆฌ๊ธฐ ์ง์            |
| viewDidAppear     | ํ๋ฉด์ View๋ค์ ๊ทธ๋ฆฐ ํ               |
| viewWillDisappear | ํ๋ฉด์ด ์ฌ๋ผ์ง๊ธฐ ์ง์                   |
| viewDidDisappear  | ํ๋ฉด์ด ์ฌ๋ผ์ง ํ                      |
