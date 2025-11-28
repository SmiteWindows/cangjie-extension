/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:            01_02_a06_01

  @Level:         1

  @Assertion:       1.2(6) Newline characters encountered before the end of the “maximal matching” are treated as 
                    separators between tokens and the newline character at the end is treated as the terminator 
                    of the expression or declaration.

  @Description:     Check that newline characters encountered inside variable declaration are not produce new line
                    and newline characters at the end is treated as terminator.

  @Mode:            run

  @Negative:        no

  @Structure:       single

*/
import utils.assert.Assert

main() {
    let string1: String = "/n dwsgdfsg /n weoigher /n"
    let string2: String = "/n/r dwsgdfsg /n/r"

    let number1: Int32 = 12 *
    7

    let number2: Int32 = 12 + 22 - 
    
    8

    Assert.equals(26, string1.size)
    Assert.equals(18, string2.size)
    Assert.equals("/n dwsgdfsg /n weoigher /n", string1)
    Assert.equals("/n/r dwsgdfsg /n/r", string2)
    Assert.notEquals("""
        dwsgdfsg 
    """, string2)

    Assert.equals(84, number1)
    Assert.equals(26, number2)

}
