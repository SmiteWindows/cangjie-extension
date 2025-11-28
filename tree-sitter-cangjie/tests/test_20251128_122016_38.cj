/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a21_01

  @Level:         1

  @Comment:      It is a header of a list of assetions which include current assertion: 
                 In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios:

  @Assertion:    3.3.1(21) Parameters in function and lambda definitions. For details, see Parameters.

  @Description:  Parameters in function definition

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

func myFunc1(mylocalUnnamed1: Int32): Int32 { mylocalUnnamed1 * 2 }
func myFunc2(mylocalNamed1!: String) { print("${mylocalNamed1}") }

func myFunc3(mylocalNamedWithDefault1!: Rune = r'F') { 
    if(mylocalNamedWithDefault1 == r'F') {
        print("default with 'F'") 
    } else {
        print("non default with '${mylocalNamedWithDefault1}'") 
    }
}

func myFunc4(mylocalUnnamed2: Int32, mylocalNamed2!: Int32): Int32 { mylocalUnnamed2 + mylocalNamed2 }

func myFunc5(mylocalNamed3!: Int32, mylocalNamedWithDefault3!: Int32): Int32 { 
    mylocalNamed3 / mylocalNamedWithDefault3 
}

func myFunc6(mylocalUnnamed4: Float32, mylocalNamedWithDefault4!: Float32 = 12.3): Float32 { 
    mylocalUnnamed4 + mylocalNamedWithDefault4 
}

main() {
    var myFunc1Res = myFunc1(32)
    Assert.equals(64, myFunc1Res)
    var myFunc4Res = myFunc4(3, mylocalNamed2:2)
    Assert.equals(5, myFunc4Res)
    var myFunc5Res = myFunc5(mylocalNamed3:16, mylocalNamedWithDefault3:2)
    Assert.equals(8, myFunc5Res)
    var myFunc61Res = myFunc6(24.6)
    Assert.equals(36.900002, myFunc61Res)
}
