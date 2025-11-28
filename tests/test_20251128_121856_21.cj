/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a10_06

  @Level:         1
  @Assertion:       2.1.10.4(10) Outside the struct definition, instance member variables and instance member functions
                    can only be accessed through the struct instance, and static member variables and static member
                    functions can only be accessed through the name of the struct type.

  @Description:     Check that an instance member function can't be accessed directly outside the struct definition.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

struct S {
    func f() { 3 }
}

main() {
    f()
    0
}
