/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a11_04

  @Level:         1

  @Assertion:   2.4.1(11) Circular reference (direct or indirect) are not allowed in one (or more) type definitions.
                In which, the method of deciding circular reference is achieved by testing whether circular references
                exist by name, rather than by using type expansion.    

  @Description: Check that the indirect circular reference are not allowed in type definitions

  @Mode:        compileonly

  @Negative:    yes

*/

type SimpleTypeName = AVeryLongAndUnintuitiveTypeName
type SomeType = SimpleTypeName
type AVeryLongAndUnintuitiveTypeName = SomeType

main(): Unit {}
