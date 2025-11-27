/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a09_02

  @Level:         1

  @Assertion:   2.1.1(9) Int64 −2^63 ~ 2^63 − 1 (-9223372036854775808 to
                9223372036854775807)

  @Description: Checks that variable declared with integer type Int64 cannot be assigned 
                by value that is less than minimal Int64 value;

  @Mode:        compileonly

  @Negative:    yes

  @Structure:   single

*/

main() {
    let intVar: Int64 = -9223372036854775809;

    return 0;
}

