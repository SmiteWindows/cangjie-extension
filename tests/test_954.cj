/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_01_a04_06

  @Level:         1

  @Assertion:       1.1(4) The letters include uppercase and lowercase ASCII Latin letters A-Z and a-z, and the digits
                    include the ASCII digits 0-9, and the underscore is the ASCII underscore _.

  @Description:     Check that a character similar to _ can't be used as an identifier.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single

*/

main() {
    let ˍ = 0
}
