/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a34_09_aadd_neg_difft

  @Level:         1

  @Assertion:    1.4(34) +=

  @Description:  Emit error if operands have different types

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/




main(ina :Array<String>) {
    var rt_opnd1: Float16 = 1.0f16;
    var rt_opnd2: IntNative = 0
    rt_opnd2+= rt_opnd1

}
