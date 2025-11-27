/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a08_01

  @Level:         1

  @Assertion:       2.1.11.5(8) Several ways are provided to facilitate the unwrapping of option type values, 
  i.e., pattern matching, the getOrThrow function, the coalescing operator (??), and the question mark operator (?).
 
  @Description:     Checks the specified ways to access option values

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

struct S {
    S(var a: ??ToString) {}
}
type T = ???S
main() {
    var v1: ??Bool = true
    Assert.isTrue(v1 is ?Option<Bool>)

    func f (x: ?(String, ??Range<UInt32>)) {
        let v1 = x.getOrThrow()
        Assert.isTrue(v1 is (String, ??Range<UInt32>))
        let r1 =  x?[1] ?? 0..1
        Assert.isTrue(r1.getOrThrow().getOrThrow() == (0u32..10u32))
        return ()
    }
    var fr: ?(Option<(String, Option<Option<Range<UInt32>>>)>) -> Unit = f
    match (fr) {
        case Some(x) => Assert.isTrue(x is (Option<(String, ??Range<UInt32>)>) -> Unit)
        case _ => Assert.fail()
    }
    let s:?T = S("qwert")
    Assert.isTrue(s is Option<?Option<?S>>)

    f(("fgdfgr", 0..10))
}
