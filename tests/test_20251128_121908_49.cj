/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a23_08

  @Level:         1

  @Assertion:    1.4(23) .. ..= Range operator
 
  @Description:  Emit error with incorrect range signs  .. .. instead .. :

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


main(ina :Array<String>) {
    0..=10..1     
    0
}