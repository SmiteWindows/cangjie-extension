/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_01_a03_02

  @Level:         1

  @Assertion:    2.4.1(3) When using type to define a type alias for a (original) type, the original type must be 
                 visible at the place where the type definition is defined.

  @Description:  Check that cannot use an alias of a type if the original type is not visible. 

  @Mode:         compileonly

  @Negative:     yes

*/

type SimpleTypeName = AVeryLongAndUnintuitiveTypeName

main(): Unit {}

