/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a02_01

  @Level:         1

  @Assertion:    3.3.1(2) The declaration of variables includes four parts: modifiers, let/var keyword , 
                 patternsMaybeIrrefutable, and a variable type.

  @Description:  Check that variable declaration using right syntax will not produce error on compilation.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

public let myPublicLetNotDefinedInitialized = 0.0
public var myPublicVarNotDefinedInitialized = 0.0
public let myPublicLetFloat16Initialized: Float16 = 0.0
public var myPublicVarFloat16Initialized: Float16 = 0.0
public let myPublicLetTupleInitialized = (0.0,"AAA")
public var myPublicVarTupleInitialized = (0.0,"BBB")
let myLetNotDefinedInitialised = 'A'
let myLetInitialised :String = "AAAA"
var myVarNotDefinedNotInitialised = -10
var myVarDefinedNotInitialised: Int64 = -130
var myVarNotDefinedInitialised = 0.0
var myVarDefinedInitialised: UInt32 = 22

main() {
    let myLetFloat16Initialized: Float16 = 0.0
    var myVarFloat16Initialized: Float16 = 0.0
    let myLetNotDefinedInitialized = 0.0
    var myVarNotDefinedInitialized = 0.0
    let myLetFloat16NotInitialized: Float16
    var myVarFloat16NotInitialized: Float16
    let myLetTupleInitialized = (0.0,"AAA")
    var myVarTupleInitialized = (0.0,"BBB")

    myLetFloat16NotInitialized = 0.0
    myVarFloat16NotInitialized = 0.0
}