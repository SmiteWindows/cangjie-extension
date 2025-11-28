/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a06_02

  @Level:         1

  @Assertion:   2.1.1(6) Int8 −2^7 ~ 2^7 − 1 (-128 to 127)

  @Description: Checks that variable declared with integer type Int8 cannot be assigned 
                by value that is less than minimal Int8 value;

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main() {
    let intVar: Int8 = -129;

    return 0;
}

