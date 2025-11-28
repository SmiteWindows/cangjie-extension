/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a03_oil_positive

  @Level:         1

  @Assertion:    1.3.1(3) octal literals must start with 0o(or 0O)
                  
  @Description:  Compiler check octal literals of all types

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main(){
   Assert.equals (0o10i8                ,0O10i8                )
   Assert.equals (0o77u8                ,0O77u8                )
   Assert.equals (0o375i16              ,0O375i16              )
   Assert.equals (0o25700u16            ,0O25700u16            )
   Assert.equals (0o7777700i32          ,0O7777700i32          )
   Assert.equals (0o7654321u32          ,0O7654321u32          )
   Assert.equals (0o12345677654321i64   ,0O12345677654321i64   )
   Assert.equals (0o10_1010_1010_1010u64,0O10_1010_1010_1010u64)
}
