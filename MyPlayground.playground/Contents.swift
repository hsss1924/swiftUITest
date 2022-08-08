import UIKit
import os
//
//var greeting = "Hello, playground"
//
//var a = 1
//
//var x = 0.0, y = 2.0
//
//print(y)
//
//var name: String
//name = "dog"
//print(name)
//
//var red, green, blue: Double
//
//var friendName = "hello"
//friendName = "bonjour"
//print(friendName,terminator: "")
//
//print("hello new world is \(friendName)")
//
//// 注释
//
//let cat = "catt"
//print(cat)
//
//let minvalue = Int8.min
//print(minvalue)
//
//typealias cat1 = Int8
//
//let dog: cat1 = 1
//
//print(cat1.min)
//
//typealias sss = String
//let name2: sss = "hhh"
//print(name2)
//
//let is_ok = false
//
//
//let httpError = (404, "Not found")
//
//print(httpError)
//
//let (statusCode, statusMessage) = httpError
//
//print("code is \(statusCode)")
//print("message is \(statusMessage)")
//
//let (justCode, _) = httpError
//
//print("code is just \(httpError.1)")
//
//let http200Status = (code: 200, des: "ok")
//
//print("code is \(http200Status.code)")
//
//print("des is \(http200Status.des)")
//
//let poss = "123"
//
//let num = Int(poss)
//print(num!)
//
//if let trueNum = num {
//    print("has num \(trueNum)")
//}else{
//    print("null")
//}
//
//if var tnum = num {
//    tnum += 1
//    print(tnum)
//}
//
//let nameL = Int(poss)
//
//let possibleStr: String! = "haha"
//
//let forcedStr: String = possibleStr
//
//print(forcedStr)
//
//
//func canthrowError() throws {
//
//}
//
//do {
//   try canthrowError()
//} catch {
//
//}
//
//let age = 3
//assert(age >= 3, "stop")
//print(age)
//
////precondition(age > 3, "is not ok")
//
//let newa = 10
//var newb = 5
//newb = newa
//
//print("hello"+"world")
//
//let newa1 = -1
//
//
//
//var nulla: Int? = nil
//var nullb = 9
//let needNum = nulla ?? nullb
//
//for index in 1...5 {
//    print("now index is \(index)")
//}
//let someString = "some  stringliteral value"
//
//let wiseWords = "\"Image is more important than knowledge\""
//let dollarSign = "\u{1F496}"
//print(dollarSign)
//
//let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
//let catString = String(catCharacters)
//print(catString)
//// 打印输出：“Cat!🐱”
//
//
//
//var steno = "car is the best all the world!!!"
//steno[steno.startIndex ]
//
//for index in steno.indices {
////    print("\(steno[index])",terminator: "")
//}
//var welcome = "hello"
//welcome.insert("!", at: welcome.startIndex)
//
//let index = steno.endIndex
//
//var someInt: [Int] = [1,2,3]
//print("someInt is of type [Int] with \(someInt.count)")
//for (index, value) in someInt.enumerated() {
//    print("\(index)上的是\(value)")
//}
//var favoriteGenres: Set = ["Classical", "Hip hop"]
//if let removedGenre = favoriteGenres.remove("Rock") {
//    print("\(removedGenre)? I'm over it.")
//} else {
//    print("I never much cared for that.")
//}
//// 打印“Rock? I'm over it.”
////var thisSet: Set = ["ceshi1", "ceshi1"]
////print(thisSet)
//
//var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//if let airportName = airports["DUB"] {
//    print("The name of the airport is \(airportName).")
//} else {
//    print("That airport is not in the airports dictionary.")
//}
//// 打印“The name of the airport is Dublin Airport.”
//
//var namesOfIntegers: [Int: String] = [:]
//// namesOfIntegers 是一个空的 [Int: String] 字典
//namesOfIntegers = [1: "s"]
//namesOfIntegers = [:]
//
//func sayhello() -> String {
//    return "hello"
//}
//func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
//    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
//}
//someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
//someFunction(parameterWithoutDefault: 1)



let name = ["char", "alex", "ewa", "barry"]
func backWord(_ s1: String, _ S2: String) -> Bool {
    return s1 > S2
}

//var result = name.sorted(by: { (s1, s2)  in s1 > s2})
//var result = name.sorted {$0 < $1}
//print(result)
//let digitNames = [
//    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
//    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
//]
//let numbers = [510]
//
//let strings = numbers.map {
//    (number) -> String in
//    var number = number
//    var output = ""
//    repeat {
//    output = digitNames[number % 10]! + output
//        print("now is " + output)
//        number /= 10
//        print("number is \(number)")
//    }while number > 0
//    return output
//}
//print(strings)


//枚举
//enum CompassPoint: String {
//    case north, south, east, west
//}
//
//
//let sunsetDirection = CompassPoint.west.rawValue
//// sunsetDirection 值为 "west"
//
//let possiblePlanet = CompassPoint(rawValue: "s")


//类和结构体

//struct Resolution {
//    var width = 0
//    var hegiht = 0
//}
//class VideoMode {
//    var resolution = Resolution()
//    var interlaced = false
//    var name: String?
//}
//let someResolution = Resolution()
//let someVideoMode = VideoMode()
//someVideoMode.resolution.width = 100
//
//let vga = Resolution(width: 100, hegiht: 200)
//
//struct FixedLengthRange {
//    var firstValu: Int
//    let length: Int
//}
//var rangeOfThreeItems = FixedLengthRange(firstValu: 0, length: 3)

//struct Point {
//    var x = 0.0, y = 0.0
//}
//struct Size {
//    var width = 0.0, height = 0.0
//}
//struct Rect {
//    var origin = Point()
//    var size = Size()
//    var center: Point {
//        get {
//            let centerX = origin.x + (size.width / 2)
//            let centerY = origin.y + (size.height / 2)
//            return Point(x: centerX, y: centerY)
//        }
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
//    }
//}
//var square = Rect(origin: Point(x: 0.0, y: 0.0),
//    size: Size(width: 10.0, height: 10.0))
//let initialSquareCenter = square.center
//square.center = Point(x: 15.0, y: 15.0)
//print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// 打印“square.origin is now at (10.0, 10.0)”

//属性包装器

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// 打印“The point is now at (3.0, 4.0)”
