/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_04_a09_01

  @Level:         1
  @Assertion:    2.2.1.4(9) If the type of = right expression is the same as
                 the type of the array, the array will be copied to cover the
                 current slice range, which requires the size of the right
                 expression to be the same as the slice range, otherwise an
                 exception will be thrown at runtime.

  @Description:  Checks that "slice assignment" with array of elements of the
                 type same as array element type on the right works as expected

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    let size = 20
    let a = Array<Int64>(size) { i => 1 << i }

    a[3..8] = [9, 9, 9, 9, 9]
    for (i in 0..size) {
        if (i > 2 && i < 8) {
            Assert.equals(9, a[i])
        } else {
            Assert.equals(1 << i, a[i])
        }
    }

    return 0
}
