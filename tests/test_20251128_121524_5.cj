/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a06_01

  @Level:         1

  @Assertion:    2.1.6.2(6)  
 let obj = "apples"
 let count = 10
 let interps1 = "There are ${count * count} ${obj}."
 // The result of "interps1" is: There are 100 apples.
 let error = "Empty sequence is not allowed ${}" // Error

  @Description:  Positive example from spec.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main() {
  let obj = "apples"
  let count = 10
  let interps1 = "There are ${count * count} ${obj}."
  // The result of "interps1" is: There are 100 apples.
  Assert.equals("There are 100 apples.", interps1)
}