// Playground - noun: a place where people can play
/**
LKL 2015-2-3

枚举与结构体

*/
import UIKit

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescrition() -> String {
        
        switch self {
            case .Ace: return "ace"
            
            case .Jack: return "jack"
            
            case .Queen: return "queen"
            
            case .King: return "king"
            
            default: return String(self.rawValue)
            
        }
    }
}
let ace = Rank.Ace //by gashero
ace.rawValue //直接取值
ace.simpleDescrition();

let tt = Rank.Jack
tt.simpleDescrition()


enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "dismonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts    //by gashero
let heartsDescription = hearts.simpleDescription()



/*
一：结构体声明
复制代码

格式：

struct  结构体名 ｛
    定义结构体变量 第一种直接定义字段名 并且给字段名赋初始值

    var 或 let  字段名 = 初始化值

    第二种定义字段名并且指定字段类型

    var 或 let  字段名:类型
｝
①：构造函数给结构体字段 赋初始值

说明：
1: swift语言中指定结构体构造函数，是init方法

2：init执行方法，在创建结构体变量之前执行

3：在创建结构体题变量的参数必须和构造函数init 参数必须一致。

*/

struct student { //创建 结构体 student
    
    var age = 0 //直接定义一个字段名称，并且赋初始值
    
    var name:String // 直接定义一个字符串变量。
    
    //定义 无参数构造函数
    init() {
        name = "zs"
        age = 1
    }
    /*
    //定义有参构造函数
    init(Name:String,Age:Int) {
        self.name = Name //self 指的是当前结构体变量    self.name 当前结构体的变量的字段
        self.age = Age
    }
    */
    
}

var stu = student () //创建结构体的变量
println("\(stu.name),\(stu.age)")
//var stu2 = student (Name:"ls",Age:12)

/*
有参数构造函数 参数变量加 _ 用法

1:  创建结构体的对象中对应参数必须和构造函数对应的参数一致

2： 如果构造函数中参数变量前加 _ 其对应创建对象的参数，不需要变量名
*/
struct Point{
    var x = 0.0
    var y = 0.0
    
    init(_ x :Double ,_ y :Double){//构造函数中对应变量前面加 _ 其对应创建对象后面不需要变量名。
        self.x = x
        self.y = y
    }
}
var p = Point(10.0,11.0)
p.x


struct student2 {
    var  age = 0  //直接定义一个字段名称，并且赋初始值
    var  name:String  // 直接定义一个字符串变量。
}

var stu2 = student2(age:12,name:"甘超波")
var str2 = stu2.name




struct Point2{
    var x = 0.0
    var y = 0.0
}

//结构体属性
//属性 主要是get set方法

struct  CPoint {
    
    var p = Point2() //创建结构体对象
    
    //声明属性 ，get set方法
    var GPoint :Point2{
        get{
            return p
        }
        set(newPoint){
            p.x = newPoint.x
            p.y = newPoint.y
        }
        
    }
}

var p2 = Point2(x:10.0,y:11.0)
var CP = CPoint()
CP.GPoint = p2   //set
CP.GPoint        //get



/*结构体 方法

1：结构体中可以直接存储方法

注意点： 结构体中方法不能直接修改字段的值，否则会报错

*/
struct  student3 {
    var  age = 0  //直接定义一个字段名称，并且赋初始值

    //定义结构体方法
    func GetAge() ->Int{
        return age+12
    }
}
/*
注意点： 结构体中方法不能直接修改字段的值，否则会报错
*/
var stu3 = student3()
stu3.age = 12
stu3.age
stu3.GetAge()


















