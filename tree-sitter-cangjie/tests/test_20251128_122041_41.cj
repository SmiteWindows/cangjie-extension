/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a14_07

  @Level:         1

  @Assertion:    3.2.3.2(14) The scope of type parameters introduced when a generic type is declared or extension is 
                 defined start from the declaration of type parameters to the end of the type body or extension body.

  @Description:  Checks of the scope of type parameters for class declaration.  

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

open class A<T> {}

main() {
    var a : T
}
