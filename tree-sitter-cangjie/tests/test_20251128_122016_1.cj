/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a32_08_diva_neg_token

  @Level:         1

  @Assertion:    1.4(32) /=

  @Description:  Emit error with wrong token

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/




main(ina :Array<String>) {
    var rt_opnd1: IntNative ;
    var rt_opnd2: IntNative = 0
    rt_opnd1 /== rt_opnd2

}
