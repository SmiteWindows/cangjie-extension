/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:           02_04_01_a05_01

  @Level:         1

  @Assertion:      2.4.1(5) When defining a generic type alias, if the type parameters in the alias are not appeared
                   in the original type, a compiler will report a warning.

  @Description:    Check the compiler gives a warning if the type parameters in the alias do not 
                   appear in the original type

  @Mode:           compileonly

  @Negative:       no

  @CompileWarning: no

*/


type Arr<T> = Array<Int8>

main(): Unit {}
