/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_a03_01

  @Level:         1

  @Assertion:    2.1.12(3) If the provided index is greater than or equal 
                 to the length of the VArray, the compiler will report an error
                 when index value can be deduced by complier,
                 otherwise, an exception is thrown at run time.
  
  @Description:  VArray of classes. Array assignment. 
                 Emit compile error due to wrong index

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/


main() {
    var arr1: VArray<Int64, $3> = VArray<Int64, $3> { i => i }
    arr1[5]
}