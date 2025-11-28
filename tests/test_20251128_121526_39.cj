/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a20_06

  @Level:         1

  @Assertion:    3.3.1(20) In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios: Pattern between for and in in the for-in loop expression. 
                 For details, see The for-in Expression.

  @Description:  Check that local variable introduced in for-in expression in function is not visible 
                 out of function before it call

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

func myFunc() {
    for(item in ["1", "AAA", "Y"]) {
        print("${item}")
    }
}

main() {
    var myVar = item
    myFunc()
}
