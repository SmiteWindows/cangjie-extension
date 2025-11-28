/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a03_04

  @Level:         1
  @Assertion:       3.2.2(3) Names in its nested scope can be accessed directly by using the name without any 
                    qualifier, if they are not shadowed or overridden.

  @Description:     Check that we can shadow a type name and there will be a compilation error if we try to use the
                    shadowed name as the type name.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

enum A { B }

main() {
    let A: Int64
    let b: A
}
