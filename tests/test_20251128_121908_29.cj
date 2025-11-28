/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a14_01

  @Level:         1

  @Assertion:    1.2(14) For single line string literal, the string literal is terminated
                         by the first non-escaped double quotation (");

  @Description:  Check the diffrent cases when the single line string literal is terminated
                 by the first non-escape double quotation (").

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert;

main() {
    var s  : String = ""
    var o  : Int64  = 0
    let o1 : Float64 = 1.0
    
    // test case #1
    s = "${o}${o1}"
    Assert.equals("01.000000", s)
    
    // test case #2
    s = "${o} ; let o : String = \"foo\""
    Assert.equals("0 ; let o : String = \"foo\"", s)
    
    // test case #3
    s = "$o ; let obj : String = \"foo\""
    Assert.equals("$o ; let obj : String = \"foo\"", s)
    
    // test case #4
    s = "~[\"\\\r\n]"
    Assert.equals("~[\"\\\r\n]", s)
    
    // test case #5
    s = "\\t"
    Assert.equals("\\t", s)
    
    // test case #6
    s = "~ \\$"
    Assert.equals("~ \\$", s)
    
    // test case #7
    s = "${o} ~[\"\\\r\n]"
    Assert.equals("0 ~[\"\\\r\n]", s)
    
    // test case #8
    s = "${o} ~[\"\\\r\n] ${o1}"
    Assert.equals("0 ~[\"\\\r\n] 1.000000", s)
    
    // test case #9
    s = "${o} \\u{0xff}"
    Assert.equals("0 \\u{0xff}", s)
    
    // test case #10
    s = "${o} \u{4f60}\u{101}\u{ffff}abc"
    Assert.equals("0 \u{4f60}\u{101}\u{ffff}abc", s)
    
    // test case #11
    s = "0123456789abcdef"
    "1 2 3 4 5" + ""
    Assert.equals("0123456789abcdef", s)
    
    // test case #12
    s = "1"
    s = "${s} 2"
    s = "${s} 3"
    s = "${s} 4"
    s = "${s} 5"
    Assert.equals("1 2 3 4 5", s)
    
    // test case #13
    s = "abcdef \" 12345 \n"
    "12345 \" abcdef \n" + " "
    Assert.equals("abcdef \" 12345 \n", s)
}
