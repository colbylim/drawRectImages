//
//  MyView.swift
//  drawRectImages
//
//  Created by colbylim on 2020/11/17.
//

import UIKit

class MyView: UIView {
    
    private static let borderColor = UIColor.random
    
    var isVisible: Bool = false
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
    
//    VC에서 touch event 처리 하기 위해 현재 view 무시
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView: UIView? = super.hitTest(point, with: event)
        if (self == hitView) { return nil }
        return hitView
        
    }

    override func draw(_ rect: CGRect) {
//        화면에 보이지 않고 있다면 return
        if isVisible == false {
            return
        }
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.saveGState()

//        2. 커스텀 뷰에서 drawRect: 메시지를 구현하여 배경 화면을 임의의 색깔로 칠하게 하시오.
        backgroundColor = .systemBackground
        backgroundColor?.setFill()
        ctx.fill(rect)
        
//        4-1. 윤곽선의 꼭지점을 둥글게 처리
//        앞으로 그려질때 clipping 되도록 함
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        ctx.addPath(path.cgPath)
        ctx.clip()

//        3. 2번의 drawRect: 구현만 변경하여 주어진 PNG 파일 중 하나를 로드하여 화면에 표시하시오.
        let imageName = String(format: "image%02d", tag)
        UIImage(named: imageName)?.draw(in: rect)
        
//        4-2. 그 주변을 임의의 색깔을 가진 윤곽선으로 둘러싸시오.
        MyView.borderColor.setStroke()
        path.lineWidth = 10
        path.stroke()
        
        ctx.restoreGState()
    }
}
