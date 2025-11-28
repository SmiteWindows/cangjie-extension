/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a06_fpl_1

  @Level:         1

  @Assertion:    1.3.2(6) The syntax of floating point literals is:

  @Description:  Check syntax of float numbers

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert

main() {
    Assert.equals(1_0e6, 10000000.0); Assert.equals(10E-6,0.00001)       
               // DecimalLiteral DecimalExponent
    Assert.equals(.1,0.1); Assert.equals(.1e6, 100000.0); Assert.equals(.2E-5, 0.000002)    
               // DecimalFraction DecimalExponent?
    
    Assert.equals(1.1,1.1e-0); Assert.equals(2.1e6,2100000.0); Assert.equals(3.2E-5,0.000032)    
               //(DecimalLiteral DecimalFraction) DecimalExponent?)
    
    Assert.equals(1.1f16, 1.1e0f16); Assert.equals(2.1e6f32, 2100000.0f32); Assert.equals(3.2E-5f64,0.000032f64) 
             // with  FloatLiteralSuffix
    
    // 0x
    Assert.isTrue(0xCp2 >0.0)   
            // Hexadecimalprefix (HexadecimalDigits ..)  HexadecimalExponent
    
    Assert.isTrue(0x.1p1 > 0.0)  
            // Hexadecimalprefix   HexadecimalFraction   HexadecimalExponent
    Assert.isTrue(0xA.BP-10 >0.0) 
            // Hexadecimalprefix   HexadecimalDigits HexadecimalFraction   HexadecimalExponent
     //0X
    Assert.isTrue(0XCp2 >0.0)   
            // Hexadecimalprefix (HexadecimalDigits ..)  HexadecimalExponent
    
    Assert.isTrue(0X.1p1 > 0.0)  
            // Hexadecimalprefix   HexadecimalFraction   HexadecimalExponent
    Assert.isTrue(0XA.BP-10 >0.0) 
            // Hexadecimalprefix   HexadecimalDigits HexadecimalFraction   HexadecimalExponent
    0
}
