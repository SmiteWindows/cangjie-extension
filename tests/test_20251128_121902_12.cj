/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a08_03

  @Level:         1

  @Assertion:    3.2.3.2(8) Names are inaccessible beyond its scope.

  @Description:  Check that using the lambda expression is not allowed beyond its scope.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    foo()

    let foo : () -> Unit = { => 
        print("I'm foo lambda.")
    }
}
