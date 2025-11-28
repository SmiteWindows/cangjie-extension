/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a02_07

  @Level:         1

  @Assertion:    3.3.2.2(2) Static variables include static variables defined in class or struct.

  @Description:  Check that gGlobal variables cannot be static.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

static var sInt: Int32 = 0

main() {
    sInt: Int32 = 1
}
