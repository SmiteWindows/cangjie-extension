/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_04_a02_02

  @Level:         1
  @Assertion:    2.2.1.4(2) It should be noted that:
                    The step must be 1, otherwise an exception will be thrown
                    when running.

  @Description:  Checks that ranges with steps other than 1 are NOT accepted

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    let size = 20
    let a = Array<Int64>(size) { i => 1 << i }

    Assert.throws(
        { => a[1..15:2] },
        check: { e => e is IllegalArgumentException })

    Assert.throws(
        { => a[1..15:-2] },
        check: { e => e is IllegalArgumentException })

    Assert.throws(
        { => a[1..15:10] },
        check: { e => e is IllegalArgumentException })

    return 0
}
