/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:          02_04_a02_03

  @Level:         1

  @Assertion:     2.4(2) The syntax for type definition is: 
                    typeAlias
                    : typeModifier? `type` identifier typeParameters? `=` type
                    ;

                  In which, typeModifier is the optional modifier for accessibility (public), type is the keyword, 
                  and identifier is an arbitrary valid identifier, and type is any type that is visible at top-level.

                  The alias identifier and the original type type are connected with symbol =.

                  Also, a generic type alias can be defined by adding a list of type parameters (i.e., typeParameters
                  in the above definition) after the alias identifier (refer to Chapter 9 for generics).

  @Description:   Check that the typeAlias cannot be protected

  @Mode:          compileonly

  @Negative:      no

*/

protected type alias = Int64

main(): Unit {}
