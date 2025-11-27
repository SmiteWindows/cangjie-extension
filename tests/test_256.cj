/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a04_23_qm_2

  @Level:         1

  @Assertion:    1.4(4) ++ Postfix increment -- Postfix decrement ? Question mark

  @Description:  Check lexical ability of question mark operator. Variant with array

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment: if var has type  Option<Int32>.Some - it is unclear how to get Int32 arg from it
            So in assert we should to fold integer into Option<Int32>.Some()

*/


import utils.assert.Assert

main() {
    var arr:Option<Array<Int32>>
    let nn = Option<Array<Int32>>.None
    arr = nn
    Assert.isNone(arr)
    Assert.isNone(arr?[1])
    arr = [0,2,4]
    Assert.isSome(arr)
    Assert.isSome(arr?[1])
    Assert.equals(arr?[0], Option<Int32>.Some(0))
    return 0;
}

