/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a01_258

  @Level:         1

  @Assertion:    2(1) The Cangjie Programming Language is a statically typed language, 
                 i.e. type checking for ensuring safety is mostly performed at compile time.

  @Description:  Checks that attempt to assign a value of type UInt64 to a variable of type interface 
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

interface TestInterface {};

main() {
    let sourceVar: UInt64 = 1;
    var targetVar: TestInterface = sourceVar;
    return 0;
}

