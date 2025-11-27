// Test multi-line raw string literals

let s1 = #""#
let s2 = ##'#'\n'##
let s3 = ###"
    Hello,
    Cangjie
    Lang"###

func test_raw_strings() {
    println(s1)
    println(s2)
    println(s3)
}

test_raw_strings()
