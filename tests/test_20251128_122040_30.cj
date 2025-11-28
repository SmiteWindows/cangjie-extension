/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a02_01

  @Level:         1

  @Assertion:    3.2.3.3(2) The scope of the type’s type parameter starts after the type parameter declaration
                  and ends with the closing of the type.

  @Description:  Check that scope of T1, T2, T3 in a generic type definition class C<T1,T2,T3> {} starts after
                  T1, T2, T3 declarations to the end of the declaration of class C.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

class C<T1, T2, T3> {
    var a: T1
    private var b: T2
    let c: T3

    init (p1: T1, p2: T2, p3: T3) {
        this.a = p1
        this.b = p2
        this.c = p3
    }

    func getB(): T2 { b }
}

main() {
    var obj = C<Int64, String, Bool>(0, "foo", true)
    Assert.equals(0    , obj.a)
    Assert.equals("foo", obj.getB())
    Assert.equals(true , obj.c)
}
