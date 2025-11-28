/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_01_a05_07

  @Level:         1

  @Assertion:    1.1(5) A raw identifier is got by adding a pair of backquotes
                 (i.e., `..`) outside of ordinary identifiers or keywords.

  @Description:  Check that raw identifies is invalid if the corresponding
                 ordinary identifies starts with invalid symbol.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    var `"`: Int32 = 1
}
