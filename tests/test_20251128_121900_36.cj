/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_01_a07_37

  @Level:         1

  @Assertion:    1.1(7) Keywords are special strings that cannot be used as
                 (ordinary) identifiers.

  @Description:  Check if the keyword 'main' is not allowed as identifier.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Issue:        0005871

*/

main() {
    var main : Int32 = 0
}
