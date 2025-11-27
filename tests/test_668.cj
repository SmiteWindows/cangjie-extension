/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a10_01

  @Level:         1

  @Assertion:    3.3.1(10) At the semantic check stage, it is checked whether the pattern is actually irrefutable, 
                 if not, it is a compile-time error.

  @Description:  Check that variables defined with irrefutable patterns (wildcard, tuple, enum and varbinding) 
                 doesn't produce compile-time error.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

enum WeekBase {
    Monday(Bool)
}

func matchVar(inVal: Int64) {
    match (inVal) {
        case case1 => "inVal = ${case1}"
    }
}

main() {
    let (x, y) = (24, 'h')
    var _ = "asfknds"
    var myVar = 12.76
    let Monday(flag) = Monday(true)
    let (_,z) = (17,"ASFASF")
}