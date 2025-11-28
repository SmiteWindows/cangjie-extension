/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a09_01

  @Level:         1
  @Assertion:    2.2.1(9) When ElementType have subtypes, the instantiated
                 Array<ElementType> can store instances of any subtypes of
                 ElementType. For example, instances of any subtypes of
                 Object can be stored in Array<Object>.

  @Description:  Checks that Array<ElementType> can store instances of any
                 subtypes of ElementType

  @Mode:         run
  @Negative:     no
  @Structure:    complex-main
  @Dependencies: ../array_commons.cj

*/
import utils.assert.*
import array_commons.*

main(): Int64 {
    let a1 = [CM1(), CM2(), CM3()]

    Assert.isTrue(a1 is Array<M>)

    return 0
}
