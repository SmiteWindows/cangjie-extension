/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a09_06

  @Level:         1

  @Assertion:    3.2.3.2(9) For instance, local-level names are inaccessible beyond its containing block,
                            and types defined in a block are inaccessible beyond its containing block
                            (e.g., a type defined in a class cannot be the return-type of a public 
                            function of the class).

  @Description:  Check that the function defined as class member is inaccessible beyond this class.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Issue:        0006110

*/

class Test {
    public func foo() : Unit {}    
}

main() {
   foo()
}
