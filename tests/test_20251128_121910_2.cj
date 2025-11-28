/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a12_01

  @Level:         1
  @Assertion:    3.2.4(12) The following example shows shadowing due to inheritance.
                 var x = 1
                 open class A {
                     var x = 3     // this x shadows the top level x
                 }
                 class B <: A {
                     var x = 5     // error: a member of the subtype must not shadow a member of the supertype.
                     func f(x!: Int32 = 7): Unit { // this x shadows all the previous x
                     }
                 }


  @Mode:         compileonly
  @Negative:     yes

*/

var x = 1

open class A {
    var x = 3     // this x shadows the top level x
}

class B <: A {
    var x = 5     // error: a member of the subtype must not shadow a member of the supertype.
    func f(x!: Int32 = 7): Unit { // this x shadows all the previous x
    }
}

main() {
}
