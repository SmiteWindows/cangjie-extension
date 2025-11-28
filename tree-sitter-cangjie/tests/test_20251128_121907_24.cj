/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a01_14

  @Level:         1

  @Assertion:    3.2.3.3(1) The scope of classes/interface/struct’s members is the entire class/interface/struct
                  definition.

  @Description:  Check that public interface members cannot be accessible outside the interface definition.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

public interface I1 {
    func sayHW(): String { "Hello World" }
}

public interface I2 {}

class C1 <: I1 {}

class C2 <: I2 {}

main() {
    var objC2 = C2()
    var HW = objC2.sayHW() // compilation error: 'sayHW' is not a member of class 'C2'
}
