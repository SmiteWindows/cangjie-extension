// Test indentation handling

func test_indent() {
    let x = 10
    if x > 5 {
        println("x is greater than 5")
        if x > 8 {
            println("x is greater than 8")
        } else {
            println("x is between 5 and 8")
        }
    } else {
        println("x is less than or equal to 5")
    }
}

func test_nested_functions() {
    func inner1() {
        println("inner1")
        func inner2() {
            println("inner2")
        }
        inner2()
    }
    inner1()
}

func test_struct() {
    struct Point {
        x: Int32
        y: Int32
        
        func distance() {
            return Math.sqrt(x * x + y * y)
        }
    }
    
    let p = Point(x: 3, y: 4)
    println(p.distance())
}

test_indent()
test_nested_functions()
test_struct()
