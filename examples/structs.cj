// examples/structs.cj
// 结构体示例
struct Person {
    pub name: string,
    age: int
}

main() {
    let person = Person { name: "Alice", age: 30 }
    println("Name: ${person.name}, Age: ${person.age}")
}
