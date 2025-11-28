/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_04_a07_07

  @Level:         1
  @Assertion:    2.2.1.4 (7)
    let array7 = [0, 1, 2, 3, 4, 5]
    func slicingTest() {
        array7[0..5] // [0, 1, 2, 3, 4]
        array7[0..5:1] // [0, 1, 2, 3, 4]
        array7[0..5:2] // runtime exception
        array7[5..0:-1] // runtime exception
        array7[5..0:-2] // runtime exception
        array7[0..=5] // [0, 1, 2, 3, 4, 5]
        array7[0..=5:1] // [0, 1, 2, 3, 4, 5]
        array7[0..=5:2] // runtime exception
        array7[5..=0:-1] // runtime exception
        array7[5..=0:-2] // runtime exception
        array7[..4] // [0, 1, 2, 3]
        array7[2..] // [2, 3, 4, 5]
        array7[..] // [0, 1, 2, 3, 4, 5]
        array7[..4:2] // error: the 'range step' is not allowed here.
        array7[2..:-2] // error: the 'range step' is not allowed here.
        array7[..:-1] // error: the 'range step' is not allowed here.
        array7[..=4] // [0, 1, 2, 3, 4]
        array7[..=4:2] // error: the 'range step' is not allowed here.
        array7[0..5:-1] // runtime exception
        array7[5..=0] // []
        array7[..0] // []
        array7[..=-1] // []
        let temp: Array<Int64> = array7[..]
        temp[0] = 6 // temp == array7 == [6, 1, 2, 3, 4, 5]
    }

  @Description:  Checks that example from the spec produces runtime exception

  @Mode:         run
  @Negative:     no
  @Structure:    single

  @Issue:        0006517

*/
import utils.assert.*

main(): Int64 {
    let array7 = [0, 1, 2, 3, 4, 5]
    func slicingTest() {
        array7[0..5] // [0, 1, 2, 3, 4]
        array7[0..5:1] // [0, 1, 2, 3, 4]
        array7[5..0:-1] // runtime exception
        array7[0..=5] // [0, 1, 2, 3, 4, 5]
        array7[0..=5:1] // [0, 1, 2, 3, 4, 5]
        array7[..4] // [0, 1, 2, 3]
        array7[2..] // [2, 3, 4, 5]
        array7[..] // [0, 1, 2, 3, 4, 5]
        array7[..=4] // [0, 1, 2, 3, 4]
        array7[5..=0] // []
        array7[..0] // []
        let temp: Array<Int64> = array7[..]
        temp[0] = 6 // temp == array7 == [6, 1, 2, 3, 4, 5]
    }

    Assert.throws(
        { => slicingTest() },
        check: { e => e is IllegalArgumentException })

    return 0
}
