//
//  String+Extension.swift
//  DXCommonServiceKit
//
//  Created by Jack on 2021/10/8.
//

import Foundation

// MARK: -  操作字符串
extension String {
    
    /// 插入字符串
    ///
    /// - Parameters:
    ///   - text: 要插入的字符串
    ///   - index: 要插入的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_Insert(_ text: String, at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(contentsOf: text, at: insertIndex)
        return self
    }
    
    /// 插入字符
    ///
    /// - Parameters:
    ///   - text: 要插入的字符
    ///   - index: 要插入的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_Insert(_ text: Character, at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(text, at: insertIndex)
        return self
    }
    
    /// 删除字符串
    ///
    /// - Parameter text: 要删除的字符串
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_Remove(_ text: String) -> String {
        if let removeIndex = range(of: text) {
            removeSubrange(removeIndex)
        }
        return self
    }
    
    /// 删除字符串
    ///
    /// - Parameters:
    ///   - index: 删除的字符串起始位置
    ///   - length: 删除的字符串长度
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_Remove(at index: Int, length: Int) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let start = self.index(startIndex, offsetBy: index)
        let end = self.index(start, offsetBy: length)
        removeSubrange(start ..< end)
        return self
    }
    
    /// 删除字符
    ///
    /// - Parameter index: 要删除的位置
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_Remove(at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let removeIndex = self.index(startIndex, offsetBy: index)
        remove(at: removeIndex)
        return self
    }
    
    /// 替换字符串
    ///
    /// - Parameters:
    ///   - index: 替换的字符串起始位置
    ///   - length: 替换的字符串长度
    ///   - text: 要替换成的字符串
    /// - Returns: 结果字符串
    @discardableResult
    public mutating func dx_ReplaceText(at index: Int, length: Int, with text: String) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let start = self.index(startIndex, offsetBy: index)
        let end = self.index(start, offsetBy: length)
        replaceSubrange(start ..< end, with: text)
        return self
    }
    
    /// 截取字符串
    ///
    /// - Parameters:
    ///   - index: 截取的字符串起始位置
    ///   - length: 截取的字符串长度
    /// - Returns: 截取的字符串
    public func dx_Substring(at index: Int, length: Int) -> String {
        if index > count - 1 || index < 0 || length < 0 || index + length > count {
            return self
        }
        let fromIndex = self.index(startIndex, offsetBy: index)
        let toIndex = self.index(fromIndex, offsetBy: length)
        return String(self[fromIndex ..< toIndex])
    }
    
    /// 截取字符串，从指定位置到末尾
    ///
    /// - Parameter index: 截取的字符串起始位置
    /// - Returns: 截取的字符串
    public func dx_Substring(from index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        return dx_Substring(at: index, length: count - index)
    }
    
    /// 截取字符串，从开头到指定位置
    ///
    /// - Parameter index: 截取的字符串结束位置
    /// - Returns: 截取的字符串
    public func dx_Substring(to index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        return dx_Substring(at: 0, length: index)
    }
    
    /// 去除左右的空格和换行符
    ///
    /// - Returns: 结果字符串
    public func dx_Trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    //合成属性字符串
   public static func dx_attributeString(with strings: [String], strFonts: [UIFont]? = nil, strColors: [UIColor]? = nil, lineSpacing: CGFloat = 5) -> NSMutableAttributedString {
        let att = NSMutableAttributedString(string: "")

        for i in 0..<strings.count {

            let str = strings[i]
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            let attributes = [NSAttributedString.Key.paragraphStyle: style]
            let attStr = NSMutableAttributedString(string: str, attributes: attributes)
            let range = NSRange(location: 0, length: str.count)
            if let fonts = strFonts {

                var font: UIFont! = fonts.last
                if i < fonts.count {
                    font = fonts[i]
                }
                attStr.addAttribute(NSMutableAttributedString.Key.font, value: font as Any, range: range)
            }

            if let colors = strColors {

                var color: UIColor! = colors.last
                if i < colors.count {
                    color = colors[i]
                }
                attStr.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: color as Any, range: range)
            }

            att.append(attStr)
        }

        return att
    }
}

// MARK: -  编解码
extension String {
    
    /// 编码之后的url
    public var dx_UrlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 解码之后的url
    public var dx_UrlDecoded: String? {
        return removingPercentEncoding
    }
    
    /// base64编码之后的字符串
    public var dx_Base64Encoded: String? {
        guard let base64Data = data(using: .utf8) else { return nil }
        return base64Data.base64EncodedString()
    }
    
    /// base64解码之后的字符串
    public var dx_Base64Decoded: String? {
        guard let base64Data = Data(base64Encoded: self) else { return nil }
        return String(data: base64Data, encoding: .utf8)
    }
    
}

// MARK: -  验证
extension String {
    
    /// 是否是数字
    public var dx_IsNumber: Bool {
        let regex = "^[0-9]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是字母
    public var dx_IsLetter: Bool {
        let regex = "^[A-Za-z]+$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是手机号
    public var dx_IsPhoneNumber: Bool {
        let regex = "^1+[3456789]+\\d{9}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是身份证号
    public var dx_IsIDNumber: Bool {
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是6位数字
    public var dx_IsSixNumber: Bool {
        let regex = "^\\d{6}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是11位数字(手机号码长度)
    public var dx_IsElevenNumber: Bool {
        let regex = "^\\d{11}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是邮箱
    public var dx_IsEmail: Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /// 是否是密码，6-20位
    public var dx_isPassword: Bool {
        let regex = "^[@A-Za-z0-9!#\\$%\\^&*\\.~_]{6,20}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
}

// MARK: -  尺寸计算
extension String {
    
    /// 计算字符串尺寸
    ///
    /// - Parameters:
    ///   - size: 限定的size
    ///   - font: 字体
    /// - Returns: 计算出的尺寸
    public func dx_Size(with size: CGSize, font: UIFont) -> CGSize {
        if isEmpty {
            return .zero
        }
        let attributes = [NSAttributedString.Key.font: font]
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
    
    /// 计算字符串的高度
    ///
    /// - Parameters:
    ///   - width: 限定的宽度
    ///   - font: 字体
    /// - Returns: 计算出的高度
    public func dx_Height(with width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return dx_Size(with: size, font: font).height
    }
    
    /// 计算字符串的宽度
    ///
    /// - Parameter font: 字体
    /// - Returns: 计算出的宽度
    public func dx_Width(with font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)
        return dx_Size(with: size, font: font).width
    }
    
}
