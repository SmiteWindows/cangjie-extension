/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_01_a01_03

  @Level:         1

  @Assertion:   2.1.10.1(1) The syntax for the definition of member variables is:
                 variableDeclaration
                  : variableModifier* NL* (LET | VAR) 
                    NL* patternsMaybeIrrefutable ((NL* COLON NL* type)? (NL* ASSIGN NL* expression) 
                  | (NL* COLON NL* type))
                  ;

  @Description: Check that correctly defined member variables in struct, 
                according to rules above, do not produce error on compilation.

  @Mode:        compileOnly
  @Negative:    no
  @Structure:   single
*/

enum MyEnum {
    item1
    |
    item2
    |
    item3
}

struct MyStruct {
    public static let letPubStatWithoutTypeAssign = 0;
    public static let letPubStatWithoutTypeAssignExpession = (letPubStatWithoutTypeAssign == 1);

    public static let letPubStatWithTypeAssign: String = "111";
    public static let letPubStatWithTypeAssignExpession: Bool = (letPubStatWithTypeAssign == letPubStatWithTypeAssign);

    public static let _let_Pub_Stat_Wildcard_WithType_Assign: Float32 = 1.5f32;

    public static let letPubStatWithTupleTypeAssign: (Int32, Float16, Rune, Bool, String) = 
        (1i32, 2.5f16, r'a', (1 == 1), "ss");;

    public static let letPubStatWithEnumTypeAssign: MyEnum = MyEnum.item2;


    public static var varPubStatWithoutTypeAssign = 0;
    public static var varPubStatWithoutTypeAssignExpession = (varPubStatWithoutTypeAssign == 1);

    public static var varPubStatWithTypeAssign: String = "111";
    public static var varPubStatWithTypeAssignExpession: Bool = (varPubStatWithTypeAssign == varPubStatWithTypeAssign);

    public static var _var_Pub_Stat_Wildcard_WithType_Assign: Float32 = 1.5f32;

    public static var varPubStatWithTupleTypeAssign: (Int32, Float16, Rune, Bool, String) = 
        (1i32, 2.5f16, r'a', (1 == 1), "ss");;

    public static var varPubStatWithEnumTypeAssign: MyEnum = MyEnum.item2;
}


main() {
}


