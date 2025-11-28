/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:        02_01_07_a06_01

  @Level:         1
   @Assertion:   2.1.7(6) Besides, two tuple objects with identical tuple type (Type1, Type2, ..., TypeN)
                 are equal if and only if they are pair-wise equal, which means that any element pair 
                 in the same position (i.e., index) of these two tuples are equal. 

   @Description: Check that tuples are equal if internal objects are equal.
   @Mode:        run
   @Negative:    no
   @CompileWarning: Ignore
   @Structure:   single
 */

import utils.assert.Assert

main() {
    var t1: (UInt64, String) = (54, "Privet")
    Assert.isTrue((54, "Privet") == t1)

    let t2: (Float16, Bool) = (3.14, true)
    Assert.isTrue((3.14, true) == t2)

    var t3: (Rune, (Int16, Int64)) = (r'y', (-54, 64))
    Assert.isTrue((r'y', (-54, 64)) == t3)

    let t4: (Unit, Range<Int64>) = ((), 6..1 : -1)
    Assert.isTrue(((), 6..1 : -1) == t4)

    // Check that order is important
    var t5: (Int64, Int64, Int64) = (1, 2, 3)
    Assert.isTrue(t5 != (3, 2, 1))
    Assert.isTrue(t5 == (1, 2, 3))

    return 0
}
