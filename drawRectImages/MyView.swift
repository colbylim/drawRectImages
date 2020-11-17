//
//  MyView.swift
//  drawRectImages
//
//  Created by colbylim on 2020/11/17.
//

import UIKit

class MyView: UIView {

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
//        2. 커스텀 뷰에서 drawRect: 메시지를 구현하여 배경 화면을 임의의 색깔로 칠하게 하시오.
        backgroundColor = UIColor.random
        backgroundColor?.setFill()
        ctx.fill(rect)
        
//        4-1. 3번의 drawRect:에서 그린 이미지를 화면의 1/4 정도 크기의 섬네일로 표시하고, 윤곽선의 꼭지점을 둥글게 처리하고, 주어진 파일 이외의 이미지를 사용하면 안 됨.
        let height = (rect.height / 4).rounded()
        let imgRect = CGRect(x: rect.origin.x,
                             y: (rect.height / 2) - (height / 2),
                             width: rect.width,
                             height: height)
        
        let path = UIBezierPath(roundedRect: imgRect, cornerRadius: 10)
        ctx.addPath(path.cgPath)
        ctx.clip()
                
//        3. 2번의 drawRect: 구현만 변경하여 주어진 PNG 파일 중 하나를 로드하여 화면에 표시하시오.
        UIImage(named: "image01")?.draw(in: imgRect)
        
//        4-2. 그 주변을 임의의 색깔을 가진 윤곽선으로 둘러싸시오.
        UIColor.random.setStroke()
        path.lineWidth = 10
        path.stroke()
    }
}
