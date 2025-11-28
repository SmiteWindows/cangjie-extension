/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Assertion: Modifier: optional. Primary constructors can be modified with one of
              public or private, none of which are visible within the package.
              See Access Modifiers for details

  @Description: The definition of structs with a public primary constructor

  @Structure: complex-aux
*/


package p02

public var constructor_counter = 0

public struct A {
    public A() {
        constructor_counter++
    }
}

public struct AGeneric<T> {
    public AGeneric() {
        constructor_counter++
    }
}

public struct ConstWithParams {
    public ConstWithParams(x: Int64) {
        constructor_counter += x
    }
}



