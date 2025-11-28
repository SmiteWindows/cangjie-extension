/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_01_a09_01

  @Level:         1

  @Assertion:    3.2.1(9)
                 If the last item of the block is a variable declaration, the value of the block 
                 is () when the variable declaration is processed.

  @Description:  Check that the value of the block is () when the last variable declaration is processed.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {

//  Test-case 1: check that if the last item of the block is a var declaration, the value of the block is () 

    var blockRes01 : Unit = {a:Int64, b:Int64 => var add:Int64 = 7; add = add + b; var v:Int64 = 50} (1, 5)
    Assert.isTrue(blockRes01 is Unit)

//  Test-case 2: check that if the last item of the block is a let declaration, the value of the block is () 

    var blockRes02 : Unit = {a:Int64, b:Int64 => var add:Int64 = 7; add = add + b; let v:Int64 = 50} (2, 10)
    Assert.isTrue(blockRes02 is Unit)

//  Test-case 3: check that if the last item of the block is not a declaration, the value of the block is not () 

    var blockRes03 : Int64 = {a:Int64, b:Int64 => var add:Int64 = 7; a + add + b} (3, 5)
    Assert.equals(15, blockRes03)

}   //main

