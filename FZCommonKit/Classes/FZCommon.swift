//
//  FZCommon.swift
//  FZCommonServiceKit
//
//  Created by Jack on 2023/2/10.
//

import UIKit

public class FZCommon: NSObject {
    /// prefix 开头
    /// suffix 结尾
    open class func fz_MakeAttributeText(prefix: (String, [NSAttributedString.Key: Any]?), suffix: (String, [NSAttributedString.Key: Any]?)) -> NSAttributedString {
        let attributeText = NSMutableAttributedString()
        let p1 = NSAttributedString(string: prefix.0, attributes: prefix.1)
        attributeText.append(p1)
        let p2 = NSAttributedString(string: suffix.0, attributes: suffix.1)
        attributeText.append(p2)
        return attributeText
    }
    
    /// prefix 开头
    /// mid    中间
    /// suffix 结尾
    open class func fz_MakeAttributeText(prefix: (String, [NSAttributedString.Key: Any]?), mid: (String, [NSAttributedString.Key: Any]?), suffix: (String, [NSAttributedString.Key: Any]?)) -> NSAttributedString {
        let attributeText = NSMutableAttributedString()
        let p1 = NSAttributedString(string: prefix.0, attributes: prefix.1)
        attributeText.append(p1)
        let p2 = NSAttributedString(string: mid.0, attributes: mid.1)
        attributeText.append(p2)
        let p3 = NSAttributedString(string: suffix.0, attributes: suffix.1)
        attributeText.append(p3)
        return attributeText
    }
    
    /// 比较版本大小
    /// 返回-1，newVersion大，需要弹窗更新
    /// 返回0，相等
    /// 返回1，nowVersion大
    public func fz_CompareVersion(nowVersion: String, newVersion: String) -> Int {
        var numbers1 = nowVersion.split(separator: ".").compactMap { Int(String($0)) }
        var numbers2 = newVersion.split(separator: ".").compactMap { Int(String($0)) }
        let numDiff = numbers1.count - numbers2.count
        
        if numDiff < 0 {
            numbers1.append(contentsOf: Array(repeating: 0, count: -numDiff))
        } else if numDiff > 0 {
            numbers2.append(contentsOf: Array(repeating: 0, count: numDiff))
        }
        
        for i in 0..<numbers1.count {
            let diff = numbers1[i] - numbers2[i]
            if diff != 0 {
                return diff < 0 ? -1 : 1
            }
        }
        return 0
    }
    
}
