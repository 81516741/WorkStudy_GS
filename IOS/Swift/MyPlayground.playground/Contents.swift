//: Playground - noun: a place where people can play

import UIKit

//1.``的使用 一些关键字可以这样
//let hao = ["我在","马路上捡钱"]
//func hello(_ value:String,`in` items:Array<Any>) {
//    print(items)
//}

//2.字符串的一些操作
let galaxy = "Milky Way 好"
galaxy.count       // 10
galaxy.isEmpty     // false
galaxy.dropFirst() // "ilky Way "
galaxy.dropLast(3)
String(galaxy.reversed()) // " yaW ykliM"
// Filter out any none ASCII characters
//galaxy.filter { char in
//    let isASCII = char.unicodeScalars.reduce(true, {$0 && $1.isASCII})
//    print(isASCII)
//    return isASCII
//} // "Milky Way "



//3.reduce 的使用
// 将数组中的每个字符串用‘、’拼接
let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]
//func appendString(string1: String, string2: String) -> String {
//    return string1 == "" ? string2 : string1 + "、" + string2
//}
//// reduce方法中的第一个参数是初始值
//let re = stringArray.reduce("", appendString)
//print(re)
let re1 = stringArray.reduce("", {(string1, string2) -> String in
    print("--33" + string1)
    return string1 == "" ? string2 : string1 + "、" + string2
})
//print(re1)
//// $0表示计算后的结果, $1表示数组中的每一个元素
//let re2 = stringArray.reduce("", {
//    return $0 == "" ? $1 : $0 + "、" + $1
//})
//print(re2)



