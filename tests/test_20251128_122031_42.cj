/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a04_07

  @Level:         1

  @Assertion:    1.2(4) A newline character may appear between any two tokens.

  @Description:  Using the newline character as a separator for incomplete list of generic function arguments (Float64)

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @CompileWarning: Ignore

*/

main() {
    let v1 = foo<Float64>(
    (
    1.0
    +
    2.0
    )
    /
    3.0
    *

    let v2 = foo<Float64>(
    2.0
    )
}