/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a10_003

  @Level:         1

  @Assertion:   1.3.6(10) A multi-line raw string literal starts with one or more number of # character
                and a double quotation ("), followed by any valid characters 
                (except one double quotation and the same number of # characters as the beginning), 
                and is terminated only by first matched double quotation (") 
                and the same number of # characters as the beginning.

  @Description:  Checks that multi-line raw string literal can be represented 
                 with content containing one double quotation and the other number sigses as the begining.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

main(){
    let stringValue:String = ###"multi-line raw string "## "###;
    let checkingString:String = "multi-line raw string \"## ";
    Assert.equals(checkingString, stringValue, 
        reason:"multi-line raw string literal has incorrect value:\n" + stringValue);

    return 0;
}

