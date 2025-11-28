/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a19_01

  @Level:         1

  @Assertion:   2.4.1(19) 
                // a.cj
                package A
                public class ClassWithLongNameA {
                
                }
                class ClassWithLongNameB {
                
                }

                public type classA = ClassWithLongNameA // ok
                type classAInter = ClassWithLongNameA // ok

                /* error: classB can not be declared with modifier 'public', as 'ClassWithLongNameB' is internal */
                public type classB = ClassWithLongNameB
                // b.cj
                package B
                import A.*
                let myClassA: A.classA = ClassWithLongNameA()

  @Description: Сheck positive example

  @Mode:        run

  @Negative:    no

  @Structure:    complex-main

  @Dependencies: a_01.cj
*/

// b.cj
package b_01

import utils.assert.Assert
import a_01.*
import a_01

let myClassA: a_01.classA = A01()

main(): Unit {
    Assert.isTrue(myClassA is classA)
    Assert.isTrue(myClassA is A01)
}
