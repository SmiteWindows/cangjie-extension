/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a03_08

  @Level:         1

  @Assertion:    3.2.3.2(3) The scope of local variables starts after the variable declaration 
                 and ends with the closing of the block.

  @Description:  Checks that variable defined within the latest function in list of call expressions 
                 is invisible for the main function.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

func foo1() {
    let v1 : String = ""
}

func foo2() {
    foo1()
}

func foo3() {
    foo2()
}

func foo4() {
    foo3()
}

func foo5() {
    foo4()
}

main() {
    foo5()
    let v : String = v1
}
