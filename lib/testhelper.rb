direc = File.dirname(__FILE__)

require "#{direc}/file_line"
require 'pp'

module TestHelper
    module ObjectMixin
        # It will pretty print the self, with title.
        def pt(title=nil)
            location_str = caller()[0]
            if title == nil
                title = SourceFile.get_variable_name(location_str, __callee__)
            end
            puts("#{title} : #{self.inspect()}")
            self
        end
        def ptl(title=nil)
            location_str = caller()[0]
            puts("\n"+location_str)
            if title == nil
                title = SourceFile.get_variable_name(location_str, __callee__)
            end
            puts("#{title} : #{self.inspect()}")
            self
        end
        def ppt(title=nil)
            location_str = caller()[0]
            if title == nil
                title = SourceFile.get_variable_name(location_str, __callee__)
            end
            puts("#{title} :")
            pp(self)
            self
        end
        def pptl(title=nil)
            location_str = caller()[0]
            puts("\n"+location_str)
            if title == nil
                title = SourceFile.get_variable_name(location_str, __callee__)
            end
            puts("#{title} : ")
            pp(self)
            self
        end
        def flag_test(title=nil)
            location_str = caller()[0]
            puts("\n"+location_str)
            if title == nil
                title = "" 
            else
                title = title+" : " 
            end
            puts(title+"There are test codes in this place!")
            self
        end
        alias puts_with_title pt
        alias puts_with_title_lineno ptl
        alias pretty_print_with_title ppt
        alias pretty_print_with_title_lineno pptl
    end
end

class Object < BasicObject # :nodoc:
    include TestHelper::ObjectMixin
end


if __FILE__ == $0
    class ColinTest
        def inspect()
            "ColinTest"
        end
        def depth
            5
        end
        alias to_str inspect
    end
    name = "Test Helper"
    name.pt()
    name.pt("Tt's the name")
    name.ppt()
    name.ppt("Tt's the name")

    ct = ColinTest.new()
    ct.depth.pt()
    ct.ptl()
    ct.ptl("It's a new instance.")
    ct.pptl()
    ct.pptl("It's a new instance.")

    flag_test()
    flag_test("for test")
end