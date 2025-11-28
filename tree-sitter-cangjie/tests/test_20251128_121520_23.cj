/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a03_001

  @Level:         1

  @Assertion:    2(3) Static typing and strong typing facilitate programmers to discover 
                 program errors at compile time.

  @Description:  Checks that attempt to assign a value of type UInt32 to a variable of type Int32 
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    let sourceVar: UInt32 = 1;
    var targetVar: Int32 = sourceVar;
    return 0;
}


