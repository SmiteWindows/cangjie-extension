/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a15_01

  @Level:         1

  @Assertion:   2.1.1(15) UIntNative platform dependent

  @Description: Checks that variable declared with integer type UIntNative can be assigned 
                by minimal and maximal values;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

func getUIntNativeSize
    (one: UIntNative, shift7: UInt8,  shift15: UInt8,  shift31: UInt8,  shift63: UInt8): UInt64 
{
    var size: UInt64 = 0;

    var uintNativeVar: UIntNative = 0;
    try {
        uintNativeVar = one << shift7;
        size = 8;

        uintNativeVar = one << shift15;
        size = 16;

        uintNativeVar = one << shift31;
        size = 32;

        uintNativeVar = one << shift63;
        size = 64;
    } catch (e: ArithmeticException) {
        // OK        
    } catch (e: Exception) {
        // not OK        
        size = 0;
    }

    return size;
}

main() {
    var sizeOfUIntNative: UInt64 = getUIntNativeSize(1, 7, 15, 31, 63);

    //Test case 1
    Assert.notEquals(0, sizeOfUIntNative, 
        reason: """
Test case 1: Calculated size of UIntNative is not correct.
""");

    //Test case 2
    let uintVar01: UIntNative = 0;
    Assert.equals(0, uintVar01, 
        reason: """
Test case 2: A variable, declared with type UIntNative
and assigned by minimal UIntNative value, has unexpected value.
""");

    //Test case 3
    var maximalUIntNativeValue: UIntNative = 0;

    if (sizeOfUIntNative == 8) {
        maximalUIntNativeValue = 255;
    }

    if (sizeOfUIntNative == 16) {
        maximalUIntNativeValue = 65535;
    }

    if (sizeOfUIntNative == 32) {
        maximalUIntNativeValue = 4294967295;
    }

    if (sizeOfUIntNative == 64) {
        maximalUIntNativeValue = 18446744073709551615;
    }

    let uintVar02: UIntNative = maximalUIntNativeValue;
    Assert.equals(maximalUIntNativeValue, uintVar02, 
        reason: """
Test case 3: A variable, declared with type UIntNative
and assigned by maximal UIntNative value, has unexpected value.
""");

    return 0;
}

