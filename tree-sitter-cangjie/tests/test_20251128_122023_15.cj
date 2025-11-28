/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a07_02

  @Level:         1
  @Assertion:       2.1.10.4(7) Members modified with public are visible both inside and outside the struct definition
                    and can be accessed outside struct in the form of structInstance.varName and
                    structInstance.funcName(arguments) (structInstance denotes an instance of struct), respectively.

  @Description:     Check that public struct member variable can be accessed outside the struct via
                    `structInstance.varName` and public struct member function can be accessed outside the struct via
                    `structInstance.funcName(arguments)`.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

struct S {
    public let v: Int64 = -1
    public func f(arg1: Int64, arg2: Int32) { arg1 + Int64(arg2) }
}

main() {
    Assert.equals(-1, S().v)
    Assert.equals(1, S().f(S().v, 2))
}
