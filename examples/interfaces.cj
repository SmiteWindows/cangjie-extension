// examples/interfaces.cj
// 接口示例
interface Drawable {
    func draw()
}

struct Circle {
    radius: float
}

extend Drawable <: Circle {
    func draw() {
        println("Drawing a circle with radius {self.radius}")
    }
}

main() {
    let circle = Circle { radius: 5.0 }
    circle.draw()
}
