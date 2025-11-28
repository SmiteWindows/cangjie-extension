/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a02_02

  @Level:         1

  @Assertion:    3.2.3.3(2) The scope of the type’s type parameter starts after the type parameter declaration
                  and ends with the closing of the type.

  @Description:  Check that scope of T1 type parameter starts after T1 declaration to the end of the declaration 
                  of interface I.
  
  @Mode:         run

  @Negative:     no

  @Structure:    single

*/
import utils.assert.Assert

interface I<T1> {
    func f(p: T1): T1
    func callF(p:T1) :T1 {f(p)}
 }

class C<T1> <: I<T1> {
    public func f(p: T1):T1 { p }
}

main() {
    Assert.equals(2023 , C<Int64>().f(2023))
    Assert.equals(r'C'  , C<Rune>().f(r'C'))
    Assert.equals("foo", C<String>().callF("foo"))
}
