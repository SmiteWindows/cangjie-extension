/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a02_06

  @Level:         1

  @Assertion:   2.1.10(2) The following grammar shows the definition of struct types:
                 structDefinition
                  : structModifier? 'struct' identifier typeParameters? ('<:' superInterfaces)? 
                    genericConstraints? structBody
                  ;
  
                 structBody
                  : '{'
                   structMemberDeclaration*
                   structPrimaryInit?
                   structMemberDeclaration*
                  '}'
                  ;
  
                 structMemberDeclaration
                  : structInit
                  | staticInit
                  | variableDeclaration
                  | functionDefinition
                  | operatorFunctionDefinition
                  | macroExpression
                  | propertyDefinition
                  ;

                In above, structModifier indicates the modifier of struct, and struct is the keyword, 
                and identifier is the name of the struct type. 
                typeParameters and genericConstraints are list of type variables 
                and their constraints (refer to chapter 9 for generics), respectively.

  @Description: Checks that struct definition causes compilation error when 
                genericConstraints refer to type not declared in typeParameters.

  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

interface Interface01 {};
interface Interface02 {};
struct Struct<T1, T2> where T1 <: Interface01, T3 <: Interface02 {
}

main() {
    return 0;
}

