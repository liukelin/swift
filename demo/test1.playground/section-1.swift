// Playground - noun: a place where people can play
/**
    LKL 2014-1-19
*/
import UIKit

//string   int
var str = "Hello, playground"
println(str)

var a = "var"
let b = "dw"

let mystring:String = "liukelin"
let age:Int = 24

let mystring1 = mystring+"\(age)"  //"{}"
let mystring2 = mystring+String(age)
var mystring3 = mystring+"\(mystring)"
var mystr1 = "echo \(age+age)"
var mystr2 = "echo \(age)\(age)"

// 其他类型 AnyObject
var tt:AnyObject

//List
var arr = ["qw","qqww","eeqwqw"]     //数组
println(arr[1])
var arr2 = ["key1":"val1","key2":"val2"] //字典
println(arr2["key2"])


/*数组
    定义：
第一种格式
    var  变量: 类型[] = [变量值，变量值,...]
第二种格式
    var  变量 ＝[变量值，变量值,...]*/

//创建数组  var 变量  ＝ 类型[] ()
//var arrStr = [int]()
var arr32 = [Int]()
//arr32 += 2
arr32.append(4)
var arr1 = [1,2,3]
arr1.append(4)
println(arr1)

/*字典 （字典的 key 一定为字符串）
    定义： var dic:Dictionary<类型 ,类型>
第一种格式：
    var  dic:Dictionary<String ,Int>= ["H1":1,"H2":2]
第二种格式：
    var  dic = ["H1":1,"H2":2]
*/
var strss = ["str":"aa" ,"hell0":"swift"]
strss.updateValue("bb" ,forKey:"str")
strss
strss["str"] = "cc"
strss
//创建一个空的可变字典  var 变量 = Dictionary<key类型，value类型（）
var arrsss = Dictionary<String,Int> ()
var arss2 = [:]


/*
混合定义 (可以多重嵌套)
 1 .数组字典  Array<Dictionary<类型,类型>>
 2 .数组数组  Array<Array<>>
 3 .字典字典  Dictionary<类型,Dictionary<类型,类型>>
 4 .字典数组  Dictionary<类型,Array<>>
*/
//let emptyDictionary = Dictionary<String, Float>()
//定义 数组 var x =


//if xxx {}
var str6:String?="test1"
str6=nil
var str7:String?="test2"

var str8 = "hehe"
if let name=str6{
    str8 = "hell,\(name)"
}
if let name1=str7{
    let str9 = "hell,\(name1)"
}


let vegetable = "red pepper"
switch vegetable {
    
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log"
case "cocumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper")://后缀  asPrefix:前缀和hasSuffix:后缀
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup.123321"
}
//vegetableComment


/*==============循环=============*/
//for value in array{}  循环数组
var ksr=0
let arr3 = [1,2,3,4,5,6,7,8,9,10]
for v in arr3 {
    if v<5 {
        ksr+=v
    }else{
        ksr-=v
    }
}
println(ksr)

//for (key,value) in array{} 循环字典
//字典数组，二维 循环字典
let interestingNumbers = ["Prime": [2, 3, 5, 7, 11, 13],"Fibonacci": [1, 1, 2, 98 ,5, 8],"Square": [1, 4, 9,16, 25],]

var largest = 0
var larMax = ""
for (key, val) in interestingNumbers{
    for val2 in val {
        if val2 > largest {//取最大
            largest = val2
            larMax = key
        }
        
    }
}
largest
larMax

var n = 2
while n < 100 {
    n = n * 2
}
n

var m = 2
do {
    m = m * 2
}while m < 100  //不满足条件继续循环  满足条件 跳出循环
m
/**
var firstForLoop = 0
for i in 0..3 {     //范围
    firstForLoop += i
}
firstForLoop**/

var firstForLoop2 = 0
for var i=0;i<3;i++ {     //范围
    firstForLoop2 += i
}
firstForLoop2


