/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a11_03

  @Level:         1

  @Assertion:   2.1.1(11) UInt8 0 ~ 2^8 − 1 (0 to 255)

  @Description: Checks that variable declared with integer type UInt8 cannot be assigned 
                by value that is greater than maximal UInt8 value;

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main() {
    let intVar: UInt8 = 256;

    return 0;
}

