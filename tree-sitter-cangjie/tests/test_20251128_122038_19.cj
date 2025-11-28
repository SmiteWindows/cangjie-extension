/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a05_05

  @Level:         1

  @Assertion:       2.1.10.5(5) Using StructName<Type1, Type2, ..., TypeK>(labelValue1, labelValue2, ..., labelValueN)
                    for defining instances of generic structs. The only difference from defining an instance of a
                    non-generic struct is that type variables need to be instanced for generic struct, i.e., `Type1` to
                    `TypeN` should be given.

  @Description:     Check that it isn't possible to create a generic struct instance using an instance instead of a
                    type variable.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

struct S<T1> {}

main() {
    S<S<Int64>()>()
}
