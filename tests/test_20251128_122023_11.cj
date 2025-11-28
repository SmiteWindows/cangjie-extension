/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a42_02_aor_char_neg

  @Level:         1

  @Assertion:    1.4(42) ||=

  @Description:  Emit error if compound logic OR (=||) applies  to char.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = Rune;
let ct0        :  TestedType  = '\u{A}'
let ct_opnd1   :  TestedType  = '\u{B}'

main(ina :Array<String>) {
    var res1: TestedType =  ct_opnd1;
    res1 ||= ct0
    0
}
