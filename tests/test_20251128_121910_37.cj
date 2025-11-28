/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a14_01

  @Level:         1
  @Assertion:       2.1.1.2(14) The following are examples of self-increment (decrement) operations on integers.
                        main() {
                            var i: Int32 = 5
                            var j: Int32 = 6
                            i++ // i=6
                            j-- // j=5
                            return 0
                        }

  @Description:     Check that the Spec example works.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

main() {
    var i: Int32 = 5
    var j: Int32 = 6
    i++ // i=6
    j-- // j=5

    Assert.equals(6, i)
    Assert.equals(5, j)

    return 0
}
