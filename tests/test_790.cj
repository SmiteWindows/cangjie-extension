/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a24_71

  @Level:         1

  @Assertion:    3.3.1(24)  To use keywords as variable names, a pair of backticks ( `)s must be used 
                 (such as `open` and `throw`).

  @Description:  Check that variable can be defined as Contextual Keyword w/o a pair of backticks ( `)
                 Case:static public immutable class member with identifier equal "abstract"

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

  @Issue: 0005872 

*/

class MyClass {
    static public let abstract = false
}

main() {
}
