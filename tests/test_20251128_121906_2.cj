/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a01_03

  @Level:         1

  @Assertion:       2.1.11.5(1) Option type is a generic enum type defined as follows:
 enum Option<T> { Some(T) | None }

 
  @Description:     Checks that Option does not define == operator
  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @Issue:           6503

  @Comment:

*/

main() {
    let a = Some(100) == None<Int64>
}
