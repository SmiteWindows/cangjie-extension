/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a22_02

  @Level:         1

  @Comment:      It is a header of a list of assetions which include current assertion: 
                 In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios:

  @Assertion:    3.3.1(22) Resource specifications in the try-with-resource expression. For details, see Exceptions

  @Description:  Check that resources for try-with-resource expression defined as variables in "try" block 
                 are not visible in "catch" block.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class NumberOutput <: Resource {
    private var count: Int64
    private let maxVal: Int64

    NumberOutput(val: Int64) {
        this.count = 0
        this.maxVal = val
    }

    public func isClosed(): Bool {
        return true
    }

    public func close(): Unit {
        return
    }

    public func getCount() {
        this.count
    }

    public func putNumber(inVal: Int64) {
        this.count++
        if(this.count>this.maxVal) {
            throw ArithmeticException("Limit was exceed")
        } else {
            print("${inVal}")
        }
    }
}

main() {
    var myRange: Range<Int64> = 0..5:1
    try (outputNumber: NumberOutput = NumberOutput(5)) { 
        for(num in myRange) { 
            outputNumber.putNumber(num)
            print("count is ${outputNumber.getCount()}") 
        } 
    } catch ( _ ) { 
        var tmpCount = outputNumber.getCount()
        print("count is ${tmpCount}") 
        print("Exception!!!") 
    } 
}
