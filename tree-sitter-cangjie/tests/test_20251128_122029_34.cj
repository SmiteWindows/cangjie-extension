/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:          02_04_a02_01

  @Level:         1

  @Assertion:     2.4(2) The syntax for type definition is: 
                    typeAlias
                    : typeModifier? `type` identifier typeParameters? `=` type
                    ;

                  In which, typeModifier is the optional modifier for accessibility (public), type is the keyword, 
                  and identifier is an arbitrary valid identifier, and type is any type that is visible at top-level.

                  The alias identifier and the original type type are connected with symbol =.

                  Also, a generic type alias can be defined by adding a list of type parameters (i.e., typeParameters
                  in the above definition) after the alias identifier (refer to Chapter 9 for generics).

  @Description:   Check the syntax for typealias

  @Mode:          run

  @Negative:      no

  @Structure:    complex-main

  @Dependencies: aux_a02_01.cj

*/

import utils.assert.Assert
import aux_a02_01.*

type SN = AVeryLongAndUnintuitiveTypeName
type MyGeneric<T> = GenericTypeName<T>
type uF = ()->Unit
type u = Unit

func foo(): Unit {}

main(): u {
    let a1: Int64 = 0
    let a2: AVeryLongAndUnintuitiveTypeName = 1
    let a3: SN = 3
    let a4: GenericTypeName<Int8> = [3, 2]
    let a5: MyGeneric<Int16> = [2, 1]

    Assert.isTrue(a1 is Int64)
    Assert.isTrue(a1 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a1 is SN)
    
    Assert.isTrue(a2 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a2 is Int64)

    Assert.isTrue(a3 is SN)
    Assert.isTrue(a3 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a3 is Int64)

    Assert.isTrue(a4 is Array<Int8>)
    Assert.isTrue(a4 is GenericTypeName<Int8>)

    Assert.isTrue(a5 is Array<Int16>)
    Assert.isTrue(a5 is GenericTypeName<Int16>)
    Assert.isTrue(a5 is MyGeneric<Int16>)

    Assert.isTrue(foo is uF)
}
