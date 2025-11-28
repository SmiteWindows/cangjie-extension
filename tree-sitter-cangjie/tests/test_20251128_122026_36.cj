/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_04_a10_01

  @Level:         1
  @Assertion:    2.2.1.4(10)
        let arr = [1, 2, 3, 4, 5]
        arr[..] = 0
        // arr = [0, 0, 0, 0, 0]
        arr[0..2] = 1
        // arr = [1, 1, 0, 0, 0]
        arr[0..2] = [2, 2]
        // arr = [2, 2, 0, 0, 0]
        arr[0..2] = [3, 3, 3] // runtime exception
        arr[0..2] = [4] // runtime exception
        let arr2 = [1, 2, 3, 4, 5]
        arr[0..2] = arr2[0..2] // ok
        // arr = [1, 2, 0, 0, 0]
        arr[0..2] = arr2 // runtime exception
        arr[..] = arr2 // runtime exception

  @Description:  Checks that cleaned-up example from the spec works

  @Mode:         run
  @Negative:     no
  @Structure:    single

  @Issue:        0006520

*/

main(): Int64 {
    let arr = [1, 2, 3, 4, 5]
    arr[..].fill(0)
    // arr = [0, 0, 0, 0, 0]
    arr[0..2].fill(1)
    // arr = [1, 1, 0, 0, 0]
    arr[0..2] = [2, 2]
    // arr = [2, 2, 0, 0, 0]
    let arr2 = [1, 2, 3, 4, 5]
    arr[0..2] = arr2[0..2] // ok
    // arr = [1, 2, 0, 0, 0]
    arr[..] = arr2

    return 0
}
