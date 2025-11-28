/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a08_u64

  @Level:         1

  @Assertion:    1.3.1(8) The suffixes in IntegerLiteralSuffix ... 
                  
  @Description:  Compiler checks that number with suffix u64 has type UInt64 

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main() {
   Assert.isTrue(0b1010_1010_11010_1010_1u64 is UInt64)
   Assert.isTrue(0o1010_7771010_777u64 is UInt64)
   Assert.isTrue(0x1a10da_11a10da_1u64 is UInt64)
   Assert.isTrue(56105610u64 is UInt64)
}
