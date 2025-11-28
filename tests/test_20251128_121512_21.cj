/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a02_007

  @Level:         1

  @Assertion:   1.3.6(2) A single-line string literal consists of zero or more characters 
                (except non-escaped character " and alone character \) 
                enclosed by a pair of double quote character (i.e., ").


  @Description:  Checks that single-line string literal can be represented with double character \.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

main(){
    let stringValue:String = "single-line string literal with double character \\";
    let checkingString:String = "single-line string literal with double character " + "\\";
    Assert.equals(checkingString, stringValue, 
        reason:"The single-line string literal with double character \\ has incorrect value (" + stringValue +")");
    return 0;
}

