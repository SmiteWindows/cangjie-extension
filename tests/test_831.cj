/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         demo_01

  @Description:  helper file with function definition for timed tests

  @Mode:         run
  @Negative:     no
  @Structure:    complex-aux
  @Dependencies:
  @Comment:
*/

class Runner {
    var counter:Int64

    init() {
        counter = 0
    }

    func endlessLoop():Future<Int64> {
        return spawn {
            while (true) {
                counter++
            }
            return counter
        }
    }
}

func runConstantTime(prefix:String, time:Int64) {
    let r = Runner()

    try {
        let res: Option<Int64> = r.endlessLoop().getResult(time * 1_000_000_000)
        print("${prefix}: val = ${res}, counter = ${r.counter / 1_000_000}M\n")
    } catch (e: Exception) {
        print("${prefix}: Exception occured\n")
    }
}