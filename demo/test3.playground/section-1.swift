// Playground - noun: a place where people can play
/**
LKL 2015-2-2
class 对象与类
*/
import UIKit

var str = "Hello, playground"

//类
class Shape {
    //属性
    var numberOfSides = 0
    //方法
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    func simpleDescription2(name:String) ->String {
        return "A shape with \(name) sides."
    }
}
var ShapeObj = Shape() //新建对象
ShapeObj.numberOfSides = 12
ShapeObj.simpleDescription()
ShapeObj.simpleDescription2("liukelin")


//构造函数
class NamedShape {
    var numberOfSides:Int = 0
    var name:String
    init(name: String) { //构造函数需要传入该值
        self.name = name+" kelin" //self 用来区分 name 属性和 name 参数，self:指明本类属性
    } //by gashero
    
    func simpleDescription() -> String {
        return "A Shape with \(numberOfSides) sides."
    }
    func simpleDescriptionInit()-> String {
        return "A Shape with \(name) sides." //  此时的 name为类属性
    }
}
var NamedShapeObj = NamedShape(name: "liu") //
NamedShapeObj.simpleDescription()
NamedShapeObj.simpleDescriptionInit()


//子类
class Square: NamedShape { //继承 NamedShape 类
    var sideLength: Double
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)    //加载 父类 init 构造函数
        numberOfSides = 4
    }
    func area() -> Double {
        return sideLength * sideLength
    }
    /**
    override func simpleDescription() -> String { //override：重载父类方法的实现
        return "A square with sides of length \(sideLength)."
    }**/
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()


// getter 和 setter
class EquilateralTriangle: NamedShape{
    
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)   //加载 父类 init 构造函数
        numberOfSides = 3
    }
    var perimeter: Double{
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0 // set写法1 newValue 为 set 进来的值
        }
    }
    
    var perimeter2 :String{
        get{
            return name
        }
        set(newValue2){     //set写法2 newValue2 为 set 进来的值
            self.name += newValue2+" set 方法"
        }
        
    }

    func namess()->String{
        return name
    }
    
    override func simpleDescription() -> String {
        return " length \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
triangle.perimeter       //get 3.0*3.1
triangle.perimeter = 9.9 //set  sideLength = 9.9 / 3.0  此处造成了 sideLength值得改变
triangle.sideLength
triangle.simpleDescription()
triangle.namess()

triangle.perimeter2 = " 我的名字 "
triangle.perimeter2


//EquilateralTriangle 的构造器  willSet 和 didSet
class TriangleAndSquare {
    var triangle:EquilateralTriangle {
        
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        //self.triangle(size, name);
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
triangleAndSquare.square.sideLength
triangleAndSquare.triangle.sideLength
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
triangleAndSquare.triangle.sideLength

//缺省时，一个方法有一个同名的参数，调用时就是参数本身。你可以指定第二个名字，在方法内部使用。
class Counter {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes times: Int) {
        count += amount * times
    }
}
var counter = Counter()
counter.incrementBy(2, numberOfTimes: 7)



















