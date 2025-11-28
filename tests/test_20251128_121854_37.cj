/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         03_04_01_01_a01_04
  @Assertion:    3.4.1.1(1) Default access modifier, without any keyword modifiers.
                 Members declared with the default access modifier are visible to
                 members within the same package.

  @Description:  Checks that function with default access modifier defined
                 in default package is not visible in named package.

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    complex-main
  @Dependencies: aux_test_a01_04.cj
  @Comment:

*/
package pack1

main() {
    testFunc()
}
