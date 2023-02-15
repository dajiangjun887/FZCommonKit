//
//  UIView+Extension.swift
//  Dicos
//
//  Created by Jack on 2021/8/11.
//

import UIKit


extension UIView {
    
    // 设置圆角
    public func dx_SetCornersRadius(_ view: UIView!, radius: CGFloat, roundingCorners: UIRectCorner) {
        guard view != nil else { return }
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        maskLayer.shouldRasterize = true
        maskLayer.rasterizationScale = UIScreen.main.scale
        view.layer.mask = maskLayer
    }
    
    // 显示动画
    public func dx_FadeIn(duration: TimeInterval = 0.8, delay: TimeInterval = 0.2, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    //隐藏动画
    public func dx_FadeOut(duration: TimeInterval = 0.8, delay: TimeInterval = 0.2, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    // 设置圆角和阴影
    public func dx_SetShadowWithCornerRadius(cornerRadius:  CGFloat, shadowColor: UIColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 1, shadowRadius: CGFloat) {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}
