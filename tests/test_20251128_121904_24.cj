/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a13_002

  @Level:         1

  @Assertion:   1.3.6(13) The syntax of the multi-line raw string literal is:
                MultiLineRawStringLiteral
                    : MultiLineRawStringContent
                    ;
                fragment MultiLineRawStringContent
                    : '#' MultiLineRawStringContent '#'
                    | '#' '"' .*? '"' '#'
                    ;

  @Description:  Checks that multi-line raw string literal can be represented with empty content
                 and with different number of new lines.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
//test case N1
    let stringValue_01:String =###"
"###;
    let checkingString_01:String = "\n";
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"The multi-line raw string literal with empty content and with 1 new line has incorrect value:\n" + stringValue_01);

//test case N2
    let stringValue_02:String =###"

"###;
    let checkingString_02:String = "\n\n";
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"The multi-line raw string literal with empty content and with 2 new lines has incorrect value:\n" + stringValue_02);

//test case N3
    let stringValue_03:String =###"



"###;
    let checkingString_03:String = "\n\n\n\n";
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"The multi-line raw string literal with empty content and with 4 new lines has incorrect value:\n" + stringValue_03);

    return 0;
}




