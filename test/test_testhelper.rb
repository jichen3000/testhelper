require 'testhelper'

class ColinTest
    def inspect()
        "ColinTest"
    end
    alias to_str inspect
end
name = "Test Helper"
name.pt()
name.pt("Tt's the name")
name.ppt()
name.ppt("Tt's the name")

ct = ColinTest.new()
ct.ptl()
ct.ptl("It's a new instance.")
ct.pptl()
ct.pptl("It's a new instance.")

flag_test()
flag_test("for test")
