/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a40_04_aor_f32

  @Level:         1

  @Assertion:    1.4(40) |=

  @Description:  Emit error with float type.  Float32.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = Float32;

main(ina :Array<String>) {
    var res1: TestedType =  0.0f32;
    res1 |= 1.0f32;
}