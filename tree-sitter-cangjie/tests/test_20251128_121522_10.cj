/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a04_xil_positive

  @Level:         1

                  
  @Assertion:    1.3.1(4) and hexadecimal literals must start with 0x(or 0X).
                  
  @Description:  Compiler check hex literals of all types

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
main(){
   Assert.equals (0x3ai8        ,0X3ai8        )
   Assert.equals (0x77u8        ,0X77u8        )
   Assert.equals (0x37di16      ,0X37di16      )
   Assert.equals (0x257fu16     ,0X257fu16     )
   Assert.equals (0x7777i32     ,0X7777i32     )
   Assert.equals (0x763c1u32    ,0X763c1u32    )
   Assert.equals (0x12fff321i64 ,0X12fff321i64 )
   Assert.equals (0x10_10cf10u64,0X10_10cf10u64)
}
