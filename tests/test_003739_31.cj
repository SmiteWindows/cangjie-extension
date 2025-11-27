/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:      02_01_05_a05_01

  @Level:         1

  @Assertion: 2.1.5(5)
              The compiler will raise warnings for the dead code detected.

  @Description: Check warning for the dead code after break.

  @Mode: run

  @Negative: no

  @CompileWarning: no

  @Comment: The only expressions which have Nothing type are: break, continue, return and throw.

*/

main() {
    for (v in [1, 2, 3, 4, 5]) {
        if (v == 1) {
            break;

            // Dead code.
            print(v)
        }
    }
}

