import UIKit

class DraggableView: UIView {
    var dragType: DragType = .none
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        // Gesture Event에 반응하는 함수
        switch pan.state {
            case .began:
                print("누르는 순간")
            case .changed:
                // print("누르고 움직일 때")
                let delta = pan.translation(in: self.superview)
                
                var viewPosition = self.center
                if dragType == .X {
                    viewPosition.x += delta.x
                } else if dragType == .Y {
                    viewPosition.y += delta.y
                } else {
                    viewPosition.x += delta.x
                    viewPosition.y += delta.y
                }
                
                self.center = viewPosition
                pan.setTranslation(CGPoint.zero, in: self.superview)
            case .cancelled, .ended:
//                print("누른 상태에서 그냥 멀리 이동하는 경우")
//                print("그리고 끝났을 때")
                if self.frame.minX < 0 {
                    self.frame.origin.x = 0
                }
                if let hasSuper = self.superview {
                    if self.frame.maxX > hasSuper.frame.maxX {
                        self.frame.origin.x = hasSuper.frame.maxX - self.bounds.width
                    }
                }
            default:
                break
        }
    }
    
    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
//        self.addGestureRecognizer(pan)
        fatalError("init(coder:) has not been implemented")
    }
}
