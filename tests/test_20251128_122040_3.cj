/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a08_i8

  @Level:         1

  @Assertion:    1.3.1(8) The suffixes in IntegerLiteralSuffix ... 
                  
  @Description:  Compiler checks that number with suffix i8 has type Int8 

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main() {
   Assert.isTrue(0b00101010i8 is Int8)
   Assert.isTrue(0o00101i8 is Int8)
   Assert.isTrue(0x041i8 is Int8)
   Assert.isTrue(10i8 is Int8)
}
