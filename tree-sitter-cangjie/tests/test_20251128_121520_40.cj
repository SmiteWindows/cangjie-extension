/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a09_04

  @Level:         1

  @Assertion:    3.2.3.2(9) For instance, local-level names are inaccessible beyond its containing block,
                            and types defined in a block are inaccessible beyond its containing block
                            (e.g., a type defined in a class cannot be the return-type of a public 
                            function of the class).

  @Description:  Check that the variable defined in the lambda expression is inaccessible beyond this one.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let foo : () -> Unit = { => 
        let v : Int32 = -1
    }

    let v1 : Int32 = v
}
