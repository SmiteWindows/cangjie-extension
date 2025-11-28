/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:      02_01_11_01_a01_14

  @Level:         1

  @Assertion: 2.1.11.1(1)
              The syntax of the definition of enum types is:

              enumDefinition
                  : enumModifier? 'enum' identifier typeParameters?
                    ('<:' superInterfaces)? genericConstraints? '{' enumBody '}'
                  ;

              enumBody
                  : '|'? caseBody ('|' caseBody)*
                    (functionDefinition |
                     operatorFunctionDefinition |
                     propertyDefinition |
                     macroExpression)*
                  ;

              caseBody
                  : identifier ('(' type (',' type)* ')')?
                  ;

              In above, enumModifier indicates the modifier (public) of enum, and enum is the keyword, and identifier
              is the name of the enum type.

              typeParameters and genericConstraints are list of type variables and their constraints (refer to chapter
              10 for generics), respectively.

  @Description: Check enumBody whith instance member declaration causes a compilation error.

  @Mode: compileonly

  @Negative: yes
*/

enum E {
    | A
    | B

    var x = 0
}

main() {}

