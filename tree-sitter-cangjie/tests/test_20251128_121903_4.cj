/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a02_01

  @Level:         1

  @Assertion:       2.1.11.1(2) A number of caseBodies (i.e., constructors) can be defined in enumBody, 
  and each constructor   can have no parameters or have a set of parameters with different types, 
  with | separating multiple constructors, the first constructor can be preceded by an optional |.


  @Description:     Checks that enum can have multiple constructors w/o and w/ parameters of different types

  @Mode:            run
  @Negative:        no
  @Structure:       single

*/

struct St {
    var i = 575
}

interface I2 {}
open class A2{}

class B2 <: A2 & I2 {}

enum En {
    A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W |X | Y | Z
    | A(Int8) | B(UInt8) | C(Int16) | D(UInt16) | E(Int32) | F(UInt32) | G(Int64) | H(UInt64) | I(Bool) | 
    J(Rune) | K(IntNative) | L(UIntNative) | M(Float16) | N(Float32) | O(Float64) | P(Unit) | Q(String) 
    | R(Rune, Int64) | S(Range<Int64>) | T((Rune)->String) | U(St) | V(Option<St>) | W(Array<St>) |X(I2) 
    | Y(A2) | Z(Int8, Int16, Int32, Int64, IntNative, UInt8, UInt16, UInt32, UInt64, UIntNative, Float16,
      Float32, Float64, Bool, Rune, Unit, String, (Int8, Int16, Int32, Int64, IntNative), Range<UInt64>, 
      (Float32) -> Int64, St, Option<I2>, Array<A2>, I2, A2, B2/**/)
}
 

main() {
    var a = A
    var b = B
    var c = C
    var d = D
    var e = E
    var f = F
    var g = G
    var h = H(23059325u64)
    var s = S((23..5767))
    var z = Z(0i8, -35i16, -4545i32, -325632487348, IntNative(1282736), 55u8, 345u16, 3764545545u32, 
      3259474326432644u64, UIntNative(233432434), 24.434f16, 23442334.34435454f32, 5543543566.323423423,
      true, r'd', (), "asaskhehi", (21i8, 555i16, 5634534i32, 34534545, IntNative(25324324)), (343..34454),
      { f: Float32 => Int64(f) - 2234667 }, St(), Some(B2()), [A2(), B2(), A2()], B2(), A2(), B2()/**/)
}
