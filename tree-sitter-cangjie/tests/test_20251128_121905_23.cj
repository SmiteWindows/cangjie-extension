/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a02_09

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

  @Description: Checks that definition of struct, containing static Init constructor, 
                is being compiled successfully.

  @Mode:        compileOnly
  @Negative:    no
  @Structure:   single

  @Issue: 0006136, 0006390
*/

struct Struct {
    static init() {
    }
}

main() {
}

