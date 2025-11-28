/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a36_03_aleft_neg_shift_i64

  @Level:         1

  @Assertion:    1.4(36) <<=

  @Description:  Emit error with negative shift  Int64.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = Int64;
let ct0        :  TestedType  =  0i64
let ct_opnd1   :  TestedType  =  3i64
let ct_opnd2   :  TestedType  = -2i64

main(ina :Array<String>) {
    var shla: TestedType = ct_opnd1
    shla <<= ct_opnd2
}
