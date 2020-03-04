import UIKit


//var str = "Hello, playground"
//
//print(str)
//
//var variable = 42
//    variable = 50
//
//let explicitDouble: Float = 70
//
//let label = "The width is "
//let width = 94
//let widthLabel = label + String(width)
//
//
//
//
///// \(实例对象) 字符串转义 􏰿􏳾􏰚􏰙􏰛格式成字符串
//let apples = 3.0
//let appleSummary = "I have \(apples) apples"
//
//let appleSummary1 = "I have apple " + String(apples)
//
//
///// 􏲋􏲙􏱳􏶫􏶬􏱸􏰧􏶭􏶪􏱥􏰜􏶫􏶬􏳚􏳘􏱡􏶜􏲫􏶝􏱌􏵖􏲿 使用3个双引号 (""")之间的格式都会被保留下来
//let quotation = """
//I said "I have \(apples) apples."
//And then I said "I have \(apples) pieces of fruit."
//"""
//
//
///// 数组
//let array = [1,2,4,5,5]
//array[1]
///// 空数组
//[]
//
///// 字典
//let dict = ["name":"Json" , "age": "5"]
//dict["name"]
//
//
//
//var mDict = ["name":"Json" , "age": "5"]
//mDict["name"] = "youbin"
//mDict
///// 空字典
//mDict = [:]


/// 控制流 if switch  for-in while repeat-while

let source = [75 , 34 , 36 , 53 , 23]
var teamSocre = 0

for s in source{
    if s > 50 {
        teamSocre += 3
    } else {
        teamSocre += 1
    }
}
print(teamSocre)


