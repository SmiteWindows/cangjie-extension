/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a38_11_aand_neg_1

  @Level:         1

  @Assertion:    1.4(38) &=

  @Description:  Emit error with incorrect compound and operator

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = IntNative;


main(ina :Array<String>) {
    var rt: TestedType = 0;
    rt .&= 1
    0
}