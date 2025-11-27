/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_02_a06_05

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

  @Description:     Check positive cases for `(DecimalLiteral DecimalExponent
                                            | DecimalFraction DecimalExponent?
                                            | (DecimalLiteral DecimalFraction) DecimalExponent?) FloatLiteralSuffix?`
                    with the 'f16' suffix.

  @Mode:            run
  @Negative:        no
  @Structure:       single
*/

import utils.assert.Assert

main() {
    // DecimalLiteral DecimalExponent
    let a = 1e0f16 + 10e00f16 + 1_e0_f16 + 100e000f16 + 10_e00_f16 + 1_0e0_0f16 + 1__e0__f16 + 1000E0f16 + 100_E00f16 +
            10_0E0_f16 + 10__E000f16 + 1_00E00_f16 + 1_0_E0_0f16 + 1__0E0__f16 + 1___e-0f16 + 2e-00f16 + 3e-0_f16 +
            4e-000f16 + 5e-00_f16 + 6e-0_0f16 + 7e-0__f16 + 8E-0f16 + 9E-00f16 + 11E-0_f16 + 12E-000f16 + 13E-00_f16 +
            14E-0_0f16 + 15E-0__f16
    Assert.approxEquals(1573.0, a)
    // DecimalFraction DecimalExponent?
    let b = .0f16 - .00e0f16 - .0_e00f16 - .000e0_f16 - .00_e000f16 - .0_0e00_f16 - .0__e0_0f16 - .0000e0__f16 -
            .000_E0f16 - .00_0E00f16 - .00__E0_f16 - .0_00E000f16 - .0_0_E00_f16 - .0__0E0_0f16 - .0___E0__f16 -
            .1e-0f16 - .2e-00f16 - .3e-0_f16 - .4e-000f16 - .5e-00_f16 - .6e-0_0f16 - .7e-0__f16 - .8E-0f16 -
            .9E-00f16 - .01E-0_f16 - .02E-000f16 - .03E-00_f16 - .04E-0_0f16 - .05E-0__f16
    Assert.approxEquals(-4.65, b)
    // (DecimalLiteral DecimalFraction) DecimalExponent?
    let c = 1.0f16 + 10.00e0f16 + 1_.0_E0f16 + 100.000e-0f16 + 10_.00_E-0f16 + 1_0.0_0e00f16 + 1__.0__E00f16 +
            1000.0000e-00f16 + 100_.000_E-00f16 + 10_0.00_0e0_f16 + 10__.00__E0_f16 + 1_00.0_00e-0_f16 +
            1_0_.0_0_E-0_f16 + 1__0.0__0e000f16 + 1___.0___E000f16 + 2.1e-000f16
    Assert.approxEquals(1466.1, c)
}
