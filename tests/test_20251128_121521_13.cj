/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a42_03_aor_neg_1

  @Level:         1

  @Assertion:    1.4(42) ||=

  @Description:  Emit error with incorrect compound and operator

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = Bool;


main(ina :Array<String>) {
    var res1: TestedType =  ct_opnd1;
    res1 ||:= true
    0
}