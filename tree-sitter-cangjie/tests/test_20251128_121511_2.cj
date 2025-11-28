/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_01_a01_02

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
    public let letPubWithType: String;

    public let _let_Pub_Wildcard_WithType: Float32;

    public let letPubWithTupleType: (Int8, Float64, MyEnum, (Int32, Float32), String);

    public let letPubWithEnumType: MyEnum;


    public var varPubWithType: String;

    public var _var_Pub_Wildcard_WithType: Float32;

    public var varPubWithTupleType: (Int8, Float64, MyEnum, (Int32, Float32), String);

    public var varPubWithEnumType: MyEnum;

    init(init1: String, init2: Float32, init3: (Int8, Float64, MyEnum, (Int32, Float32), String), init4: MyEnum) {
        this.letPubWithType = init1;
        this._let_Pub_Wildcard_WithType = init2;
        this.letPubWithTupleType = init3;
        this.letPubWithEnumType = init4;

        this.varPubWithType = init1;
        this._var_Pub_Wildcard_WithType = init2;
        this.varPubWithTupleType = init3;
        this.varPubWithEnumType = init4;
    }
}


main() {
}


