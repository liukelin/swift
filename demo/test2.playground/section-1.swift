// Playground - noun: a place where people can play
//2015.1.31
// 函数与闭包   、元组
import UIKit

var str = "Hello, playground"


/*=================函数==============*/
/*函数
1. func  函数名（参数：类型，...） -> 返回类型 {} 参数为不可变
2. func 函数名( var 参数 : 类型,... ） ｛｝ 参数为可变
参数可以有默认值 类似 PHP
可以不用返回类型
区别于编译语言  所调用函数 必须在上面定义
*/

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
greet("Bob", "Tuesday")

//[返回多个值]使用元组(tuple)来,返回多个值
func getGasPrices() -> (Double, Double, Double) {
    return (3.59, 3.69, 3.79)  //返回一个元组
}
getGasPrices()

func getGasPrices2() -> (String, String, String) {
    return ("we", "er", "erer")
}
var k = getGasPrices2()
k.0
k.1 //取出元组元素


//[传入多个参数]函数可以接受可变参数个数，收集到一个数组中。
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    var itt = 1
    for number in numbers {
        sum += number
        itt += 1
    }
    return (sum/itt)
}
sumOf()
sumOf(42, 13, 12)

//可变参数  传入多个值  与 返回多个值
func sumOf2(numbers: Int...) -> (Int,Int) {
    var sum = 0
    var itt = 0
    for number in numbers {
        sum += number
        itt += 1
    }
    return (sum,itt)
}
sumOf2(1,2,3)

//函数嵌套
func returnFifteen() -> Int {
    var y = 10
    
    func add(){
        y += 5
    }
    add()
    
    return y
}
returnFifteen()


//函数是第一类型的。这意味着函数可以返回另一个函数。
func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


//一个函数可以接受其他函数作为参数。
func hasAnyMatches(lists:[Int], condition: Int -> Bool) -> (Int,Int) {
    var a = 0;
    var b = 0;
    for item in lists {
        if condition(item) {
            a += item
        }else{
            b += item
        }
    }
    return (a,b)
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 6, 7, 12]
hasAnyMatches(numbers, lessThanTen)

//参数可以是数组 字典 函数，定义里面元素类型
func hasAnyMatches2(lists:[String:String], condition: String -> Bool) -> (String,String) {
    var a = "";
    var b = "";
    for (k,item) in lists {
        if condition2(item) {
            a += item
        }else{
            b += item
        }
    }
    return (a,b)  //返回元组
}
func condition2(str: String) ->Bool {
    return str=="ABC"  //判断字符串是否相等
}
var strs = ["a":"DSC", "b":"ABC", "c":"SSD"]
hasAnyMatches2(strs, condition2)

//参数可以为为默认
func SayHello(val:String = "AA")->String{
    return "value=\(val)"
}
SayHello(val: "10") //带参数
SayHello()//不带参赛

//可以没有返回值
func SayHello2( val:String ,val2:String){
     "value=\(val)"
}
SayHello2("sd","33")

//可变类型参数
func SayHello3(var val:String){
    val = "\(val) aacc"
    println(val)
}
SayHello3("wer ")

//外部参数，（相当于参数别名）
func SayHello4(value2 : String, joinStr value1 : String){
    var  str = value2 + value1
    println("\(str)")
}
SayHello4("hello ",joinStr: "Swift")

//输入输出参数    func 函数名（inout 函数变量 类型）
//inout 修辞的变量 函数内部可以直接修改，其外部可以获取到 比如：sort 函数
func SayHello (inout value:String){
    value = "\(value) Swift"
}
var str5 = "hello"
SayHello(&str5)  //此时传递 字符串的地址
println(str5)

//*返回 函数
// 自加函数
func  Add(num : Int)->Int{
    return num + 1
}
//自减函数
func zj(num : Int)->Int{
    return num - 1
}
//函数可以返回函数
func  SayHello(num:Bool)->(Int->Int){ //其中 （Int）->Int 返回参数为整形，返回值为整形的数
    return num ? Add : zj
}
//函数参数可以是函数
func SayHello5(num:Int,zzs:Int->Int) ->Int{
    return zzs(num)
}
SayHello5(7,zj)




//===函数闭包======
//1普通
numbers.map({       // map 方法 对数组里面元素 操作
    (number: Int) -> Int in  //自定义函数参数、返回值
    let result = 3 * number  //函数体
    return result            //函数体
})
//2简化
var numbers2 = numbers.map({number in 3 * number})
numbers2



//函数闭包2
var names2 = ["Swift", "Arial", "Soga", "Donary"]

//1使用函数
func backwards(firstString: String, secondString: String) -> Bool {
    return firstString > secondString // 升序排序
}
sort(&names2, backwards) //


//2使用闭包
sort(&names2, { (firstString: String, secondString: String) -> Bool in
    return firstString > secondString
})
names2

//简化闭包
var names3 = [1, 5, 3, 12, 2]
sort(&names3, { $0 > $1 })
names3



/*
1：函数类型

函数类型
var  变量 :(类型)->返回值 ＝函数名

1:func 是函数关键字
2:Say是函数名，表示函数的地址
3:Say函数 参数是整形 返回值为布尔类型
*/
func Say(num:Int)->Bool{
    return num > 10
}
var By:(Int)->Bool = Say
var By2 = Say   //  可以省略变量类型
/*
1：Say是函数名的地址，并且函数类型，参数为整形，返回值布尔类型
2：（Int)->Bool 表示 函数类型，参数为整形 ，返回值为布尔类型。
即：By是函数变量（参数为整形，返回值为布尔类型） 指向函数名（Say)
*/

var b = By(12) //by(12)直接调用函数
var c = Say(12)
var d = By2(13)
println(b)


/*
2：闭包格式

格式 :
{
(参数:类型) ->返回类型  in

执行方法

return 返回类型
}

说明：
1；闭包主要指向函数类型
2：闭包的参数必须和函数类型的参数和返回值一致
*/

func GetList(arr:[Int] , pre:(Int->Bool)) ->[Int]{
    //定义一个空的可变整形集合
    var tempArr = [Int]()
    for temp in arr {
        if pre(temp){
            tempArr.append(temp);
        }
    }
    return tempArr;
}
/*
调用Getlist 说明
第一个参数 整形数组 [1,2,3,4]
第二个参数  闭包 来指向给 函数类型 。
{(s) in return s>2} 闭包类型说明，参数为整形,返回值为布尔类型
*/
let arr=GetList([1,2,3,4],{(s:Int) in return s>2})
println(arr)


/*
3:闭包简写方法

　　1；第一种简写 ：省略 参数类型和括号

　　2:第二种简写 : 省略 参数类型和括号，return关键字

　　3:第三种简写 ： 参数名称缩写 (用$0代表第一个参数，$1代表第二个参数,以此类推)
*/
//第一种简写 ：省略 参数类型和括号
var Arr = GetList([1,2,3,4],{s in return s>2})

//第二种简写 : 省略 参数类型和括号，return关键字
Arr = GetList([1,2,3,4], {s in s>2})

//第三种简写 ： 参数名称缩写 $0 $1 $2....
Arr = GetList([1,2,3,4],{$0>2}) //其中$0表示第一个参数


//4：尾随闭包

print("ech  ");






















