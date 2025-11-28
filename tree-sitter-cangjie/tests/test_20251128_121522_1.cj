/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_05_01_a01_02

  @Level:         1

  @Assertion:   2.5.1(1) For any two types T1 and T2, we say T1 is equivalent to T2 (denoted as 𝑇1 ≡ 𝑇2) if at least 
                one of the following conditions is satisfied:
                If T1 is defined by a type alias type T1 = T2.
                Inside the definition of class and inside the extend of class, T1 is the name of class and T2 is This.
                The names of T1 and T2 are identical (reflexive property).
                𝑇2 ≡ 𝑇1 (symmetric property).
                There exists a type 𝑇𝑘 which satisfies that 𝑇1 ≡ 𝑇𝑘 and 𝑇𝑘 ≡ 𝑇2 (transitive property).

  @Description: Check that types are not equivalent if none of the conditions are met

  @Mode:        run

  @Negative:    no

*/

import utils.assert.*

type F64Ty = Float64
type F32Ty = Float32

open class C {
    func foo() { 
        this
    }
}

extend C {
    func bar() {
        this
    }
}

class MyCls {}

main() {

    // Check that an alias of one type is not equivalent to an alias of another type
    let a1: F64Ty = 0.96
    let a2: F32Ty = 0.96
    Assert.isFalse(a1 is F32Ty)
    Assert.isFalse(a2 is F64Ty)

    // Check that `This` is not equivalent to another class type
    let c = C()
    Assert.isFalse(c.foo() is MyCls)
    Assert.isFalse(c.bar() is MyCls)

    // Check that types with different names are not equivalent
    let Var1: Int64 = 45 
    let Var2: Int32 = 45 
    Assert.isFalse(Var1 is Int32)
    Assert.isFalse(Var2 is Int64)
}
