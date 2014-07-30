require 'method_source'
require 'pp'


### location_str like 
# /Users/colin/work/testhelper/trial/show_source_helper.rb:12:in `<main>'
def get_file_name_and_no(location_str)
    source_infos = location_str.split(":")
    [source_infos[0], source_infos[1].to_i]
end

def mm()
    # puts(caller()[0])
    # pp(attrs[1].to_i)
    MethodSource.source_helper(
        get_file_name_and_no(caller()[0]))
end

puts("123"+
    "123"+mm())
