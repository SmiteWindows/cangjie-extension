/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a01_10

  @Level:         1
  @Assertion:       2.1.1.3(1) Except bitwise operations, all operations defined on integer types are defined for
                    floating-point types, including arithmetic operation, relational operation,
                    self-increment/decrement operation, unary plus (minus) number operation, conditional operation, and
                    (compound) assignment operation.

  @Description:     Check that bitwise & cannot be used for Float16.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

main() {
    1.0f16 & 1.0f16
    0
}
