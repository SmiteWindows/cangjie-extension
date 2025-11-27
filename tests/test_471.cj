/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_05_03_a01_02

  @Level:         1

  @Assertion:   2.5.3(1) In a type system with subtypes, there are cases where the least common parent of two types 
                is required, e.g. the type of an if expression is the least common parent of the types of its two 
                branches, and a match expression is similar.
                The smallest common supertype of two types is the smallest of their common supertypes. Smallest means
                that it is a subtype of all other common supertypes.
                The smallest common supertype is defined as follows: 
                for any two types T1 and T2, LUB is the smallest common supertype of T1 and T2 if the type LUB 
                satisfies the following:
                LUB <: T also holds for any type T that satisfies both T1 <: T and T2 <: T.
                Note that if LUB is no larger than the other common supertypes, then it is only necessarily the
                minimum but just a minimal.

  @Description: Сheck that if the if expression type is not the least common parent of types of its two branches,
                an error occurs

  @Mode:        compileonly

  @Negative:    yes

*/

open class Base {}
open class A <: Base {}
class Other {}

main(): Unit {
    let ifExpr1: Base = if (true) { Other() } else  { A() }
}
