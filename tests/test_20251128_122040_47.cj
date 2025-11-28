/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a12_02

  @Level:         1

  @Assertion:   2.1.1(12) UInt16 0 ~ 2^16 − 1 (0 to 65535)

  @Description: Checks that variable declared with integer type UInt16 cannot be assigned 
                by value that is less than minimal UInt16 value;

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main() {
    let intVar: UInt16 = -1;

    return 0;
}

