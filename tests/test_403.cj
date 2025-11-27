/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a18_01

  @Level:         1

  @Assertion:       2.1.11.5(18)
 class C {
  var item = 100
 }
 let c = C()
 let c1 = Some(c)
 let c2 = Option<C>.None
 let r1 = c1?.item // r1 = Option<Int64>.Some(100)
 let r2 = c2?.item // r2 = Option<Int64>.None 

 
  @Description:     Checks that positive examples behave as expected

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert


class C {
    var item = 100
}
let c = C()
let c1 = Some(c)
let c2 = Option<C>.None
let r1 = c1?.item // r1 = Option<Int64>.Some(100)
let r2 = c2?.item // r2 = Option<Int64>.None 

main() {
    Assert.equals(100, r1.getOrThrow())
    match(r2) {
      case None => ()
      case _ => Assert.fail()
    }
}
