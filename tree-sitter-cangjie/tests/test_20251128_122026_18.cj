/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a04_07

  @Level:         1
  @Assertion:   3.2.3.1(4) They must be defined and initialized before they are used.
  @Comment:     Assertion about top-level variables, whose names are introduced by let and var.
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single

*/

open class X {
  let bool2 = bool1
}

let bool1 = true

main() {
  let x1 = X()
  return 0
}