/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a17_01

  @Level:         1

  @Assertion:       2.1.11.5(17) For an expression e of type Option, e?.b means that Option<T>.Some(b) 
  is obtained when e is Some, otherwise Option<T>.None (T is the type of b), and the same for 
  the other operators. See section The Question Mark Operator for more details of the ? operator. 

  @Description:     Checks value of question mark expressions for simple values

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

class C {
    var item = 10
    var seq = ('a','c','g','t')
    func f (s:?String) {s.getOrThrow()}
}
let prim = (1,3,5,7,11)
func g(){ -1i16 }
main() {
    Assert.equals((3), (Some(prim)?[1]).getOrThrow())
    Assert.equals(-1i16, (Some(g)?()).getOrThrow())
    var a = Some(C())
    Assert.equals((10), a?.item ?? 0)
    Assert.equals(("qwert"), a?.f(Some("qwert")) ?? "")
    Assert.equals(('g'), a?.seq[2] ?? 'r')

    let b = None<C>
    match (b?.item) {
      case None => ()
      case _ => Assert.fail()
    }
    Assert.equals(("hky"), b?.f(Some("qwert")) ?? "hky")
    Assert.throws({ => (b?.seq[2]).getOrThrow() }, check: { e => e is NoneValueException})
}
