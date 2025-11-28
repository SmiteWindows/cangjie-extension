/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_01_a04_04

  @Level:         1

  @Assertion:    3.2.1(4) The syntax of block is:
                    block
                         : '{' expressionOrDeclarations '}'.

  @Description:  Check that other constructions don't define blocks.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single


*/

main() {
    
//  Check that constructions with other pairs of brackets ( [} ) are not blocks
    
    let x3 = 10
    var y03 : Int64 = 3 * x3
    
    if (x3 > 0) [
        var y03 : Int64 = 300
    }
}    //main

