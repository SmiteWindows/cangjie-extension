/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Structure:       complex-aux
  @Dependencies:    aux_test_a02_01_1.cj
  @CompileWarning:  no
*/

package p

import utils.assert.Assert

import std.sync.*

public struct AuxTestA0201 {
    public func b1<T>() {
        func b2<T>() {
            Assert.isTrue(this is AuxTestA0201)
        }
        b2<AuxTestA0201>()
    }

    public mut prop b3: ReentrantMutex {
        get() {
            let b4: ReentrantMutex = ReentrantMutex()
            synchronized (b4) {
                Assert.isTrue(this is AuxTestA0201)
            }
            b4
        }
        set(b5) {
            let b6 = "c"
            unsafe {
                Assert.equals("c", b6)
            }
        }
    }

    public operator func -() {
        { =>
            Assert.isTrue(this is AuxTestA0201)
        }()
    }
}
