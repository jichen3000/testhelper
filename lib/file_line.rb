# for pry
# Pry.current_line
# Pry::VERSION
# puts "Pry.history.to_a[-1]:", Pry.history.to_a[-1]
# puts "Pry.current_line:", Pry.current_line
# puts "Pry.current.eval_string:", Pry.current.eval_string
# puts "Pry.line_buffer.last:", Pry.line_buffer.last
# puts "Pry.line_buffer:", Pry.line_buffer

module FileLine
    def self.get(file_path, line_no)
        # only test for Pry::VERSION == 0.10.0
        if file_path == "(pry)"
            return Pry.history.to_a.last
        end
        if file_path == "(irb)"
            return Readline::HISTORY.to_a.last
        end
        open(file_path) do |f|
            # tap depend on ruby > 1.9
            return f.each_line.tap{|enum| (line_no-1).times{enum.next}}.next
        end
    end
end

module SourceFile
    def self.split_file_name_and_no(location_str)
        source_infos = location_str.split(":")
        if source_infos.size == 4
            # for windows path
            [source_infos[0]+":"+source_infos[1], source_infos[2].to_i]
        else
            [source_infos[0], source_infos[1].to_i]
        end
    end

    def self.analyze_variable_name(the_line, the_callee)
        the_line.slice(0, the_line.rindex("."+the_callee.to_s)).strip()
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
            line_no = 2
            FileLine.get(file_path, line_no).must_equal(
                "  s.name        = 'testhelper'\n")
        end
    end

    describe SourceFile do
        it "splits the file name and line not from the location string" do
            location_str = "/Users/colin/work/testhelper/lib/testhelper.rb:55:in `<main>'"
            SourceFile.split_file_name_and_no(location_str).must_equal(
                ["/Users/colin/work/testhelper/lib/testhelper.rb", 55])
            location_str = "C:/Users/colin/work/testhelper/lib/testhelper.rb:55:in `<main>'"
            SourceFile.split_file_name_and_no(location_str).must_equal(
                ["C:/Users/colin/work/testhelper/lib/testhelper.rb", 55])
        end
        it "analyze variable name from a line of source" do
            the_line = "    mm.ppt()\n"
            the_callee = :ppt
            SourceFile.analyze_variable_name(the_line, the_callee).must_equal("mm")

            the_line = "    ct.depth.pt()\n"
            the_callee = :pt
            SourceFile.analyze_variable_name(the_line, the_callee).must_equal("ct.depth")

            the_line = "    ct.depth.pt('depth')\n"
            the_callee = :pt
            SourceFile.analyze_variable_name(the_line, the_callee).must_equal("ct.depth")
        end
    end
end