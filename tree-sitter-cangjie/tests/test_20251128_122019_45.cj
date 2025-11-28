/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a03_01

  @Level:         1
  @Assertion:    2.2.1(3) Values in Array<T> are ordered and are accessed
                 through the index (starting from 0).

  @Description:  Checks that Array values can be accessed via index

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    let a1 = Array<String>(10){ i => "value-${i}" }

    for (i in 0..a1.size) {
        Assert.equals("value-${i}", a1[i])
    }

    return 0
}
