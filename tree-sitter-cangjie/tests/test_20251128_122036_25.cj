/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0005817_02
  @Assertion:       Property formal definition allows non-compiled cases

  @Description:     This is a Spec issue: according to the formal definition, this code should compile successfully.
                    Case: duplicate variable access modifier.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         SpecBug v0.22.12, v0.22.13, v0.22.14. Verified for the Compiler v0.35.6, v0.37.2, v0.38.2
*/

public public let first: Int64

main() {}
