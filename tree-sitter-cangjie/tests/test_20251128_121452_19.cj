/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_a01_207

  @Level:         1

  @Assertion:   2(1) The Cangjie Programming Language is a statically typed language, 
                i.e. type checking for ensuring safety is mostly performed at compile time.

  @Description:  Checks that attempt to assign a variable of type UIntNative to a variable of type Range
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    var sourceVar: UIntNative = 0;
    var targetVar: Range<Int8> = sourceVar;
    return 0;
}


