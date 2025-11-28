/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a04_03

  @Level:         1

  @Assertion:   2.1.10(4) struct types can only be defined at top-level.

  @Description: Checks that the struct defined not at top-level (in class body)
                causes compilation error.

  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single

*/

class Class {
    struct Struct {
    }
}

main() {
}


