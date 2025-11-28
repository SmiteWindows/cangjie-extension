/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a09_03

  @Level:         1
  @Assertion:       2.1.11.1(9) As custom types, enum types do not support == (and ! =) by default. Of course, it is
possible to override the == (or ! =) operator (see Section operator overloading) to make custom
enum types support == (or ! =).

  @Description:     Checks that it is possible to override the == operator

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

var count = 0;
enum E {
    | F | D
    operator func ==(e: E) { 
        let r = count
        count++
        return r
    }
}

main() {
    Assert.equals(0, F == F)
    Assert.equals(1, F == F)
    Assert.equals(2, F == D)
    Assert.equals(3, D == F)
    Assert.equals(4, D == D)
}
