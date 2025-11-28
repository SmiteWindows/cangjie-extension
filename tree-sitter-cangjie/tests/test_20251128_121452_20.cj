/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_01_a06_01

  @Level:         1

  @Assertion:    3.2.1(6) When evaluating the value of a block, the expressions and declarations are processed 
                          in the order in which they are declared in the block

  @Description:  Checks that expressions and declarations are processed in the order in which they are in the block.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {

//  Test-case 1: Check that expressions are processed in the order in which they are in the block. 
    
    var curValue01 : String = "";
    var blockRes01 : String = { => curValue01 += "1"; curValue01 += "2"; curValue01 += "3"; curValue01 + "4"}() 
    Assert.equals("1234", blockRes01)

//  Test-case 2: Check that expressions and declarations are processed in the order in which they are in the block
    
    var curValue02 : String = "";
    var blockRes02 : String = { => curValue02 += "1"; curValue02 += "2"; 
        var extra : String = "extra"; curValue02 += extra + "3"; curValue02 + "4"}() 
    Assert.equals("12" + "extra" + "34", blockRes02)

//  Test-case 3: Check that expressions are processed in the order in which they are in the block. 
    
    var curValue03: String = "";
    var blockRes03 : String = { => curValue03 += "2"; curValue03 += "1"; curValue03 += "3"; curValue03 + "4"}() 
    Assert.notEquals(blockRes03, "1234")

}   //main


