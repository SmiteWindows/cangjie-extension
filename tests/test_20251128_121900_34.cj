/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a24_23

  @Level:         1

  @Assertion:    3.3.1(24)  To use keywords as variable names, a pair of backticks ( `)s must be used 
                 (such as `open` and `throw`).

  @Description:  Check that variable can't be defined as keyword w/o a pair of backticks ( `)
                 Case: private immutable class member with identifier equal "foreign"

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class MyClass {
    private let foreign: Float32 = 127.12
}

main() {
}
