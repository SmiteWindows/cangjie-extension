/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a01_07

  @Level:         1
  @Assertion:   3.2.3.1(1) Names declared or defined at the top-level of a source file (i.e., not enclosed in {}) 
                have top-level scope.
  @Comment:     Additionally call struct constrructor to initialize str1 constant.
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single

*/

struct Struct1 {
  let str1 = "Some string"
}

let struct1 = Struct1()
let str2 = str1

main() {
  return 0
}

