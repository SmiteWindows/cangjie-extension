// Sample Cangjie code for testing the Tree-sitter grammar

package Sample

// Variable declarations
let x: Int32 = 42
var y: Float64 = 3.14
const PI: Float64 = 3.14159

// Function declaration
func add(a: Int32, b: Int32): Int32 {
  return a + b
}

// Lambda expression
let addLambda = { (a: Int32, b: Int32) => a + b }

// Control flow
if x > 0 {
  println("x is positive")
} else {
  println("x is negative")
}

// Match expression
match x {
  case 0 => println("x is zero")
  case 1..10 => println("x is between 1 and 10")
  case _ => println("x is greater than 10")
}

// For loop
for i in 0..10 {
  println(i)
}

// While loop
while y > 0 {
  y -= 0.1
}

// Class declaration
class Person {
  let name: String
  var age: Int32
  
  init(name: String, age: Int32) {
    this.name = name
    this.age = age
  }
  
  func greet() {
    println("Hello, my name is " + name)
  }
}

// Struct declaration
struct Point {
  let x: Float64
  let y: Float64
}

// Enum declaration
enum Color {
  case Red
  case Green
  case Blue
  case RGB(r: Int32, g: Int32, b: Int32)
}

// Interface declaration
interface Printable {
  func print(): Unit
}

// Type alias
type IntList = Array<Int32>

// Generic function
func identity<T>(value: T): T {
  return value
}

// Expression with operator precedence
let result = 1 + 2 * 3 / 4 - 5
let power = 2 ** 3 ** 2 // Should be 512 (right associative)

// Member access
let person = Person(name: "Alice", age: 30)
person.greet()

// Call expression
let sum = add(1, 2)

// Index access
let arr = [1, 2, 3, 4, 5]
let first = arr[0]

// Range expression
let range = 1..10
let inclusiveRange = 1..=10

// Assignment expressions
let a = 1
a += 2
a *= 3

// Flow expression
let flowResult = 42 |> add(1) |> multiply(2)

// Coalescing expression
let optionalValue: ?Int32 = null
let defaultValue = optionalValue ?? 0

// Type test and cast
let anyValue: Any = 42
if anyValue is Int32 {
  let intValue = anyValue as Int32
}

// Spawn expression
spawn {
  println("Running in a new thread")
}

// Synchronized expression
synchronized(mutex) {
  // Critical section
}

// Quote expression
let quoted = quote(1 + 2)

// Macro invocation
@debug("This is a debug message")
func debugFunction() {
  // Debug function
}

// Struct construction
let point = Point(x: 1.0, y: 2.0)

// Array construction
let newArray = [1, 2, 3]

// Pointer operations (unsafe)
unsafe {
  let ptr = &x
  *ptr = 100
}

// Annotation
enum Case {
  @deprecated("Use newCase instead")
  case oldCase
  case newCase
}

// Constant evaluation
const COMPILE_TIME_CONST = if 1 > 0 {
  42
} else {
  0
}

// Import declaration
import Math
import { add as mathAdd } from Math
import * as MathLib from Math
