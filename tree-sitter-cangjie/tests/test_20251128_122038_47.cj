/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a03_03

  @Level:         1

  @Assertion:    1.2(3) However, the meaning of newline character is not fixed, depending on its position, 
                        it can either be used as a separator of two tokens like the space character,
                        or as an ending character of an expression or declaration like ;.

  @Description:  newline character is absent between two let declaration.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let
    x
    =
    100  let
    y
    =
    200
}
