/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a03_07

  @Level:         1

  @Assertion:    3.2.3.2(3) The scope of local variables starts after the variable declaration 
                 and ends with the closing of the block.

  @Description:  Checks that variable defined within global function is not accessible for this one.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

func foo1() {
    let v1 : Int32 = match(-1) {
        case -1 => 100
        case _  => 0
    }
}

main() {
    func foo2() { foo1() }
    print(v1)
    return 0
}
