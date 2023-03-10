//
//  UIColor+Extension.swift
//  DXCommonServiceKit
//
//  Created by mll on 2021/10/13.
//

import UIKit

extension UIColor {
    
    public static func gradientColor(colors: [UIColor], height:CGFloat) -> UIColor?{
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: 1, height: height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage:UIImage(cgImage: cgImage))
    }
    
    public static func gradientColor(colors: [UIColor], width:CGFloat) -> UIColor?{
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: width, height: 1)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: CGPoint.zero, end: CGPoint(x: size.width, y: 0), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage:UIImage(cgImage: cgImage))
    }
    
    /// ?????????
    ///
    /// - Parameters:
    ///   - colors: ??????
    ///   - point: ???????????????????????????0???0????????? point??????????????????
    public static func gradientColor(colors: [UIColor], point:CGPoint) -> UIColor?{
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: point.x, height:point.y)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: CGPoint.zero, end: CGPoint(x: size.width, y: size.height), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage:UIImage(cgImage: cgImage))
    }
}
