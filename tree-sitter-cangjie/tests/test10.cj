class Node<T> where T <: ToString {
    var value: T
    let left: ?Node<T>
    let right: ?Node<T>

    public init(value: T, left!: ?Node<T> = None, right!: ?Node<T> = None) {
        this.value = value
        this.left = left
        this.right = right
    }

    public func traverse(): Unit {
        left?.traverse()
        print(value.toString())
        right?.traverse()
    }

    public func set(value: T) {
        this.value = value
    }
}

main() {
    var tree1 = Node(r'X',
        left: Node(r'B', left: Node(r'C', right: Node(r'D'))),
        right: Node(r'E', left: Node(r'F'), right: Node(r'G')))
    tree1.set(r'A')
    tree1.traverse()

    println()
    var tree2 = Node(0,
        left: Node(2, left: Node(3, right: Node(4))),
        right: Node(5, left: Node(6), right: Node(7)))
    tree2.set(1)
    tree2.traverse()
}
