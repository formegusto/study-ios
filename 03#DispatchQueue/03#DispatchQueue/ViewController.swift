//
//  ViewController.swift
//  03#DispatchQueue
//
//  Created by formegusto on 2022/07/07.
//

import UIKit

class ViewController: UIViewController {

    // main thread 확인용
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1970년도 부터 진행되고 있는 시간에 대한 숫자값
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {timer in
            self.timerLabel.text = Date().timeIntervalSince1970.description
        })
    }
    
    // main thread 에서 동작하는 경우
    // main thread : 앱에 대한 모든 Life Cycle 관리
    @IBAction func actionOne(_ sender: Any) {
        // finishLabel.text = "끝"
        
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLabel.text = "끝"
            }
        }
    }
    
    @IBAction func actionTwo(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "q1")
        
        // async는 끝나지 않고 다음 내용 진행함
        // 하지만 지금의 예와 같은 경우에는 같은 Dispatch Queue에서 진행되기 때문에
        // 순차적으로 진행이 된다.
        queue1.async(group: dispatchGroup){
            for index in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            // 이와 같은 경우에는 또 하나의 dispatch queue가 생겨난다.
            // 상위 queue는 실행시키고 끝낸다.
            // --> dispatchGroup의 입장에서는 작업이 다 끝났다라고 생각함
            // 이럴 경우에는 수동적으로 넣어줘야함
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 40..<50 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
//        queue1.async(group: dispatchGroup){
//            for index in 20..<30 {
//                Thread.sleep(forTimeInterval: 0.2)
//                print(index)
//            }
//        }
        
//         Multi-Thread 가능
         let queue2 = DispatchQueue(label: "q2")
        queue2.async(group: dispatchGroup) {
            for index in 20..<30 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        
        // group 의 끝 확인 event
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
    }
    
    func simpleClosure(_ completion: @escaping () -> Void) {
        // 긴 작업 예시
        DispatchQueue.global().async {
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            completion()
            
            // 화면에 대한 갱신은 mainThread에서 진행해주어야 한다.
//            DispatchQueue.main.async {
//                completion()
//            }
        }
//        for index in 0..<10 {
//            // 해당 쓰레드는 Main Thread
//            Thread.sleep(forTimeInterval: 0.2)
//            print(index)
//
//            // 모든 UI가 Lock이 걸림
//        }
//
//        completion()
    }
    @IBAction func actionThree(_ sender: Any) {
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        // Sync는 내 작업이 끝나기 전까지 아무도 동작할 수 없다는 나타낸다.
//        queue1.sync {
//            for index in 0..<10{
//                Thread.sleep(forTimeInterval: 0.2)
//                print(index)
//            }
//        }
//        queue2.sync {
//            for index in 10..<20{
//                Thread.sleep(forTimeInterval: 0.2)
//                print(index)
//            }
//        }
        
        // dead lock 현상
        // 상대 작업이 끝날때까지 서로 계속 기다리는 상태
        // 상위 queue1은 작업이 끝나지 않았음
        // 하지만 sync 특징 상 하위 queue1은 상위 queue1이 끝나야 함
        // 서로,, 기다리고 있음,, 대 참사라는 거죠,,
        // 정리 : 상위 queue1이 끝나길 기다리는 하위 queue1
        //  하위 queue1을 실행시키려는데 본인이 안 끝나서 실행이 안되는 상위 queue1
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
        // Dispatch main sync?
        // 무조건 Deadlock이 걸린다.
        // main thread는 여러가지 작업이 한 없이 돌아가는데,
        // sync를 써버리면? Dead Lock 무조건!
//         DispatchQueue.main.sync {
//         print("main sync")
//         }
        
        // 그럼 sync는 언제?
        // 굉장히 중요한 작업 : 모든 thread를 멈추고 필수적으로 진행시켜야 하는 작업인 경우
        // Thread Unsafe를 허용하지 않는 상황에서 쓴다. (계좌 이체 등 등)
    }
    
    @IBAction func actionFour(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        
        // QoS (Quality of Service: 우선순위)
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        // Queue가 하나일 때는
        // 우선순위가 먼저 있으면 먼저 실행된다.
        // background -> userIteractive 순으로 높음
        // userIteractive를 쓰는 경우 : 빠르게 갱신되어야 하는 UI인 경우
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
        
    }
}

// main thread 에서는 순서를 보장해주기 위해서
// 하나의 쓰레드에서 동작하도록 되어 있다. --> UI 갱신이 main thread에서만 일어나야 하는 이유

