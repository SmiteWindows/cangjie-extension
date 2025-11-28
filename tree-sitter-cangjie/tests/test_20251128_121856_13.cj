/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a11_03

  @Level:         1

  @Assertion:    1.2(11) In constant pattern, a newline character cannot be used as a separator between $
                         and the identifier following it.

  @Description:  Check when the newline character cannot be used as a separator between $
                 and the identifier following it for match expression.

  @Mode:         run

  @Negative:     no

  @Issue:        0005955

  @Structure:    single

*/

import utils.assert.Assert
main() {
    let scoreTuple = ("Allen", 90)
    var scoreResult: String = match (scoreTuple) {
        case ("Allen", score) => """
Allen got $
{score}"""
        case (_, _) => ""
    }

    Assert.equals("Allen got $\n{score}", scoreResult)
}
