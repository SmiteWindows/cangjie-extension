/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a09_06

  @Level:         1

  @Assertion:    2.1.6.1(9) A multi-line raw string literal starts with one or more number of # characters
                 and a double quotation ("), followed by any valid characters (except one double quotation
                 and the same number of # characters as the beginning), and is terminated only by first
                 matched double quotation (") and the same number of # characters as the beginning.

  @Description:  Positive test with a specific mumber of alone # which total count equal to count of begining #.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

  @Issue:      6118, 6125

*/

public var testA0906: String = ###" A "# B "# C "# "###
main() {
}