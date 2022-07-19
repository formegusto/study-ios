import UIKit

class DraggableView: UIView {
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
                viewPosition.x += delta.x
                viewPosition.y += delta.y
            
                self.center = viewPosition
                pan.setTranslation(CGPoint.zero, in: self.superview)
            case .cancelled, .ended:
                print("누른 상태에서 그냥 멀리 이동하는 경우")
                print("그리고 끝났을 때")
                default:
                    break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
