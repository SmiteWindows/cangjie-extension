/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        bug_0005878_04

  @Assertion:   0005878: Hexadecimal representation, a floating point number computes wrong.              
                  
  @Description: float hex has type Float64

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/
main() {

   let IsHexFloat32 = 0x.1p1 is Float32;
   print("IsHexFloat32 is"); println(IsHexFloat32) 
   let IsHexFloat64 = 0x.1p1 is Float64;
   print("IsHexFloat64 is"); println(IsHexFloat64) 

   let IsHexFloat16 = 0x.1p1 is Float16;
   print("IsHexFloat16 is"); println(IsHexFloat16) 

}
