/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_03_a02_01

  @Level:         1
  @Assertion:    2.2.1.3(2)
        let array9 = [0, 1, 2, 3, 4, 5]
        let array10 = [[0, 1, 2], [3, 4, 5]]
        let size1 = array9.size // size1 = 6
        let size2 = array10.size // size2 = 2

  @Description:  Checks that example from the spec works

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    let array9 = [0, 1, 2, 3, 4, 5]
    let array10 = [[0, 1, 2], [3, 4, 5]]
    let size1 = array9.size // size1 = 6
    let size2 = array10.size // size2 =

    Assert.equals(6, size1)
    Assert.equals(2, size2)
    return 0
}
