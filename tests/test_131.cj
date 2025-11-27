/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_a07_02

  @Level:         1

  @Assertion:    2.1.12(7) 4.Two VArraytypes are only considered to be the same 
                 if the type variables Tare instantiated as the same type, 
                 and the length annotation $Nare equal.
  
  @Description:  Compiler emit error, when there is assignment of unconformed sizes

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/



main() {
    let arr1:VArray<Int64, $3> = VArray<Int64, $3> { i => i }
    var arr0 : VArray<Int64,$4> = arr1;
    0
}