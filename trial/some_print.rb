require 'pp'
require 'method_source'

module TestHelper
    def self.get_file_name_and_no(location_str)
        source_infos = location_str.split(":")
        [source_infos[0], source_infos[1].to_i]
    end

    def self.get_variable_name(location_str)
        MethodSource.source_helper(
            get_file_name_and_no(location_str))
    end
    module ObjectMixin
        # It will pretty print the self, with title.
        def tp()
            location_str = caller()[0]
            pp(TestHelper.get_variable_name(location_str))
            pp(self)
        end
        def tpl()
            location_str = caller()[0]
            puts(location_str)
            # pp(self.variables)
            # pp(__callee__)
            # pp(__method__)
            # pp(__callee__)
            self.tp()
        end
        alias test_pretty_print tp
    end
end

class Object < BasicObject # :nodoc:
    include TestHelper::ObjectMixin
end
class ColinTest
    def inspect()
        "ColintTest"
    end
    alias to_str inspect
end

if __FILE__ == $0
    def mm()
        1.tpl()
    end
    ct = ColinTest.new()
    ct.tpl()
    # ct.test_pretty_print()
    # false.tp()
    # 1.tpl()
    # mm()
    # pp(__LINE__)
    # pp ct.methods
end