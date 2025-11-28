/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a02_05

  @Level:         1

  @Assertion:    3.2.3.3(2) The scope of the type’s type parameter starts after the type parameter declaration
                  and ends with the closing of the type.

  @Description:  Check that T1 type parameter cannot be accessible outside the declaration of interface I.
  
  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

interface I1<T1> {
    func f(p: T1): T1
}

interface I2 {
    func f(p: T1): T1 // compilation error: undeclared type name 'T1'
}

main() {
    return 0
}
