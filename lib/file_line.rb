module FileLine
    def self.get(file_path, line_no)
        open(file_path) do |f|
            # tap depend on ruby > 1.9
            return f.each_line.tap{|enum| (line_no-1).times{enum.next}}.next
        end
    end
end

module SourceFile
# /Users/colin/work/testhelper/lib/testhelper.rb:55:in `<main>'
# "            self.ppt()\n"
# ColintTest
# "    mm.ppt()\n"    
    def self.split_file_name_and_no(location_str)
        source_infos = location_str.split(":")
        [source_infos[0], source_infos[1].to_i]
    end

    def self.analyze_variable_name(the_line, the_callee)
        the_line.slice(0, the_line.index(the_callee.to_s)-1).strip()
    end

    def self.get_variable_name(location_str, the_callee)
        the_line = FileLine.get(*split_file_name_and_no(location_str))
        analyze_variable_name(the_line, the_callee)
    end
end

if __FILE__ == $0
    require 'minitest/spec'
    require 'minitest/autorun'

    describe FileLine do
        it "get line from the file" do
            file_path = "../testhelper.gemspec"
            line_no = 3
            FileLine.get(file_path, line_no).must_equal(
                "  s.version     = '0.0.1'\n")
        end
    end

    describe SourceFile do
        it "splits the file name and line not from the location string" do
            location_str = "/Users/colin/work/testhelper/lib/testhelper.rb:55:in `<main>'"
            SourceFile.split_file_name_and_no(location_str).must_equal(
                ["/Users/colin/work/testhelper/lib/testhelper.rb", 55])
        end
        it "analyze variable name from a line of source" do
            the_line = "    mm.ppt()\n"
            the_callee = :ppt
            SourceFile.analyze_variable_name(the_line, the_callee).must_equal("mm")
        end
    end
end