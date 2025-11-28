/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a04_05

  @Level:         1

  @Assertion: 2.1.10.2(4)
              The primary constructor name is the same as the type name.

  @Description: Check that a generic struct can not have a primary constructor
                with the same name as its supertype

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

interface SuperType {}

struct SomeName<T> <: SuperType {
    SuperType() {}
}

main() {
}