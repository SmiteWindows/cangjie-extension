/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_02_a06_17

  @Level:         1

  @Assertion:       1.3.2(6) The syntax of floating point literals is:
                       FloatLiteralSuffix
                           : 'f16' | 'f32' | 'f64'
                           ;
                       FloatLiteral
                           : (DecimalLiteral DecimalExponent
                                | DecimalFraction DecimalExponent?
                                | (DecimalLiteral DecimalFraction) DecimalExponent?) FloatLiteralSuffix?
                           | (Hexadecimalprefix (HexadecimalDigits
                                                | HexadecimalFraction
                                                | (HexadecimalDigits HexadecimalFraction)) HexadecimalExponent)
                       DecimalFraction
                           : '.' DecimalFragment
                           ;
                       DecimalFragment
                           : DecimalDigit (DecimalDigit | '_')*
                           ;
                       DecimalExponent
                           : FloatE Sign? DecimalFragment
                           ;
                       HexadecimalFraction
                           : '.' HexadecimalDigits
                           ;
                       HexadecimalExponent
                           : FloatP Sign? DecimalFragment
                           ;
                    FloatE
                    : [eE]
                    ;
                    FloatP
                    : [pP]
                    ;
                    Sign
                    : [-]
                    ;
                    Hexadecimalprefix
                        : '0' [xX]
                        ;

  @Description:     Check that `Hexadecimalprefix HexadecimalDigits HexadecimalExponent HexadecimalFraction` is an
                    invalid FloatLiteral (HexadecimalFraction and HexadecimalExponent are swapped).

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
*/

main() {
    // Before: Hexadecimalprefix HexadecimalDigits HexadecimalFraction HexadecimalExponent
    //                0x               0                   .0                  p0
    // After: Hexadecimalprefix HexadecimalDigits HexadecimalExponent HexadecimalFraction
    //                0x               0                   p0                  .0
    let a: Float16 = 0x0p0.0
}
