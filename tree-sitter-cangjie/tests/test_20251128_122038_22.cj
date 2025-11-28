/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a04_22

  @Level:         1

  @Assertion:    3.2.3.2(4) A variable must be defined and initialized before being used.

  @Description:  Checks that the variable is defined but not initialized before being used 
                 in do-while loop causes compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    var tmp : Int32
    do {
        tmp++
    } while (tmp < 1)
}

