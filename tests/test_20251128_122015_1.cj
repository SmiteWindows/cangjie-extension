/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_01_a03_01

  @Level:         1
  @Assertion:    3.3.2.1(3)
    func f() {
         let a = 1                   // Define and initialize immutable variable a.
         let b: Int32                // Define immutable variable b without initialization.
         b = 10                      // Initialize variable b.
         var aa: Float32 = 3.14  // Define and initialize mutable variable aa.
    }


  @Description:  Checks that example from spec works as expected

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/

import utils.assert.Assert

let CONST_FLOAT: Float64 = 1.2353546346e24

main() {
    let a = 1                   // Define and initialize immutable variable a.
    let b: Int32                // Define immutable variable b without initialization.
    b = 10                      // Initialize variable b.
    var aa: Float32 = 3.14  // Define and initialize mutable variable aa.

    Assert.equals(1, a, reason: "Immutable initied value must match")
    Assert.equals(10, b, reason: "Immutable not-initied value must match")
    Assert.equals(3.14, aa, reason: "Mutable value must match")
}
