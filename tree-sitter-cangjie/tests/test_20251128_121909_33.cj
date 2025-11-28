/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a41_04_aand_neg_2

  @Level:         1

  @Assertion:    1.4(41) &&=

  @Description:  Emit error if operands are not of the logical types

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



main(ina :Array<String>) {
    var res1: Int32 =  1;
    var res2: Int32 =  2;
    res1 &&= res2
    0
}
