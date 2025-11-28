/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_05_04_a01_02

  @Level:         1

  @Assertion:   2.5.4(1) As there are cases of contra-variance in subtype relationships (see the Variance section 
                under the Generics chapter for definitions), such as the parameter type of a function type, the 
                greatest common subtype of the two types will be calculated.
                The greatest common subtype of two types is the greatest of their common subtypes. Greatest means 
                that it is a supertype of all other common subtypes.
                The greatest common subtype is defined as follows: 
                for any two types T1 and T2, GLB is the greatest common subtype of T1 and T2 if the type GLB 
                satisfies the following:
                T <: GLB also holds for any type T that satisfies both T <: T1 and T <: T2.
                Note that if GLB is no smaller than the other common subtypes, then it is only necessarily the
                maximum but just a maximal.

  @Description: Check that if at least one condition is met, the type will be greatest common supertype.

  @Mode:        compileonly

  @Negative:    yes

*/

open class Base {}
open class A <: Base {}
class B <: A{}
class C <: A{}
class Other {}

func foo<T>() where T<:C {}

main(): Unit {
    foo<A>()
}
