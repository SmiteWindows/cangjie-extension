/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a02_04

  @Level:         1

  @Assertion:    3.2.3.2(2) The variables defined within a block has higher level of scope 
                 than the ones defined outside.

  @Description:  Checks that variable defined within if-else block is invisible for the main function.

  @Mode:         run

  @Negative:     yes

  @Structure:    single

*/

import utils.assert.Assert

func myBoolFunc(i: Int64){
    if(i > 0){
        return false
    }
    return true
}

main() {
    var v1 : Int32 = 10
    let v2 : Int64 = 11
    let v3 : String = "bla-bla"
    if (myBoolFunc(1)) {
    } else {
        let v1 : Int32 = v1 * v1
        let v2 = v2 / 11
        let v3 = "if_else block"
        Assert.equals(10, v1)
        Assert.equals(11, v2)
        Assert.equals("bla-bla", v3)
    }
}
