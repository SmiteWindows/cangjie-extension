/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a08_04

  @Level:         1

  @Assertion:    3.2.3.2(8) Names are inaccessible beyond its scope.

  @Description:  Check that the variable cannot be used beyond its scope.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let v  : Int32 = v1
    let v1 : Int32 = 0
}
