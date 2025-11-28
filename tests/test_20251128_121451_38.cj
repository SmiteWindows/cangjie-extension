/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a03_014

  @Level:         1

  @Assertion:   2.1.1(3) Signed integer types include Int8, Int16, Int32, Int64 and IntNative,
                which are used to represent types of signed integer values whose lengths are
                8-bit, 16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that:
                - variable declared with signed integer type IntNative can be assigned by 
                  value, whose length is equal to length of IntNative;
                - variable declared with signed integer type IntNative cannot be assigned by 
                  value, whose length is greater than length of IntNative;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

func getIntNativeSize(): Int64 {

    var size: Int64 = 0;
    try {
        var intVar64: Int64 = -128;
        var intVar_native: IntNative = IntNative(intVar64);
        size = 8;

        intVar64 = -32768; 
        intVar_native = IntNative(intVar64);
        size = 16;

        intVar64 = -2147483648; 
        intVar_native = IntNative(intVar64);
        size = 32;

        intVar64 = -9223372036854775808; 
        intVar_native = IntNative(intVar64);
        size = 64;
    } catch (e: OverflowException) {
        //println(e.toString());
        // OK        
    } catch (e: Exception) {
        //println(e.toString());
        // not OK        
        size = 0;
    } finally {
        //println("the finally block");
    }

//    print("The size of IntNative is ");
//    println(size);
    return size;
}

main() {
    var size_of_IntNative: Int64 = getIntNativeSize();
//Test_case_1
    Assert.notEquals(0, size_of_IntNative, 
        reason:"""
Test_case_1: Calculated size of IntNative is not correct.
""");

    var intNative_var_01: IntNative = (1 << (size_of_IntNative - 1));
    var expected_intNative_var: IntNative = 0;

    if (size_of_IntNative == 8) {
        expected_intNative_var = -128;
    }

    if (size_of_IntNative == 16) {
        expected_intNative_var = -32168;
    }

    if (size_of_IntNative == 32) {
        expected_intNative_var = -2147483648;
    }

    if (size_of_IntNative == 64) {
        expected_intNative_var = -9223372036854775808;
    }

//Test_case_2
    Assert.equals(expected_intNative_var, intNative_var_01, 
        reason:"""
Test_case_2: Calculated minimal IntNative value, 
using calculated size of IntNative, is not correcti.
""");

//Test_case_3
   var is_failed: Bool = false;
   var error_reason: String = "";
    var intNative_var_02: IntNative = 0;
    try {
        intNative_var_02 = 1 << size_of_IntNative;
        is_failed = true;
        error_reason = 
"""
Test_case_3: Variable of IntNative type is assigned successfully
by value, whose length is greater than length of IntNative. 
""";
    } catch (e: ArithmeticException) {
        // OK        
        //println(e.toString());
    } catch (e: Exception) {
        // not OK        
        //println(e.toString());
        is_failed = true;
        error_reason = 
"""
Test_case_3: Try to assign variable of IntNative type 
by value, whose length is greater than length of IntNative,
causes unexpected Exception: 

""" + e.toString();
    }

    Assert.equals(false, is_failed, 
        reason: error_reason);

    return 0;
}


