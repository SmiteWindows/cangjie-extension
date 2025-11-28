/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_01_a02_bil_positive

  @Level:         1

  @Assertion:    1.3.1(2) Binary literals must start with 0b(or 0B,)
                  
  @Description:  Compiler check binary literals of all types

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main(){
   Assert.equals(0b0010_1010i8                    ,0B0010_1010i8                    )
   Assert.equals(0b1010_1010u8                    ,0B1010_1010u8                    )
   Assert.equals(0b0010_1010_1010_1010i16         ,0B0010_1010_1010_1010i16         )
   Assert.equals(0b1010_1010_1010_1010u16         ,0B1010_1010_1010_1010u16         )
   Assert.equals(0b11_0010_1010_1010_1010i32      ,0B11_0010_1010_1010_1010i32      )
   Assert.equals(0b11_1010_1010_1010_1010u32      ,0B11_1010_1010_1010_1010u32      )
   Assert.equals(0b11_11_0010_1010_1010_1010i64   ,0B11_11_0010_1010_1010_1010i64   )
   Assert.equals(0b1111_11_1010_1010_1010_1010u64 ,0B1111_11_1010_1010_1010_1010u64 )
}
