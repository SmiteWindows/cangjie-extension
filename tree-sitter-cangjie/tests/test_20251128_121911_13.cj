/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a06_05

  @Level:         1

  @Assertion:       2.1.11.2(6) When it is not possible to resolve, both the enum constructor and the function 
  cannot be used directly, so the enum constructor needs to be used by type prefixing 
  and the function needs to be used by prefix qualification.


  @Description:     Checks that conflicting class and enum constructor
  produce compilation error

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @Issue:           6508

*/

enum E1 {
    | F
    | F1(Bool)
    | F2(Rune, Int8)
}

class F1 {
    F1(var b: String) {}
}

class F2 {
    F2(var c: Rune, var i: Int8) {}
}

let c = F2(r'z', 8_i8)

main() {
}