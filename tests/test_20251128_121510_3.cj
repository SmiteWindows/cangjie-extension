/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a08_01

  @Level:         1

  @Assertion:   2.1.12.1(8) The type argument <T, $N> of VArray cannot be omitted.
  
  @Description:  Negative test with omitted type argument. Must emit error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $..>

*/

main() {
    let arr3: VArray<$1> = [1]
}