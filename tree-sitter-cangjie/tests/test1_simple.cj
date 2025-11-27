// Simplified test for class inheritance and option type
open class NodeA {
    public NodeA(protected var value: Rune, 
        protected let left!: ?NodeA = None, 
        protected let right!: ?NodeA = None) {}
}

class NodeB <: NodeA {
    public init(value: Rune, 
        left!: ?NodeA = None, 
        right!: ?NodeA = None) {
        super(value, left: left, right: right)
    }
}
