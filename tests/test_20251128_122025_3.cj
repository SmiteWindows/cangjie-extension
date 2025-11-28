/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a02_04

  @Level:         1

  @Assertion:    3.2.3.3(2) The scope of the type’s type parameter starts after the type parameter declaration
                  and ends with the closing of the type.

  @Description:  Check that scope of T1 in a generic type definition class C1<T1> {} limited by declaration of 
                  class C1.
  
  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class C1<T1> {
    var a: T1
 
    init (p: T1) {
        this.a = p
    }
} 


main() {
    var foo: T1 // compilation error: undeclared type name 'T1'
}
