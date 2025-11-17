// examples/enums.cj
// 枚举示例
enum Color {
    Red,
    Green,
    Blue
}

main() {
    let color = Color::Red
    match color {
       case Color::Red => println("Red"),
       case Color::Green => println("Green"),
       case Color::Blue => println("Blue")
    }
}
