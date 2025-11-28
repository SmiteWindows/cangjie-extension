/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a03_neg_f16

  @Level:         1

  @Assertion:    1.3.2(3) 
                 An exponential part (prefixed with e or E) is required when there is no decimal part

  @Description:  Compiler checks that float number has no fractional part and emit errors  f16

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/
main() {
    2f16
    0
}
