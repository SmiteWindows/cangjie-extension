/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a04_28_qm_3_neg_1

  @Level:         1

  @Assertion:    1.4(4) ++ Postfix increment -- Postfix decrement ? Question mark

  @Description:  Check question mark operator. Variant with call. Using w/o ? For some

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/


import utils.assert.Assert

main() {
    let foo = {i: Int64 => i + 1}
    let f1 = Option<(Int64) -> Int64>.Some(foo)
    let f2 = Option<(Int64) -> Int64>.None
    let r3 = f1(1) // error: missed ? for Option type
    Assert.isNone(f2)
    Assert.isSome(f1)
    return 0;
}

