# Test Helper

Why did I write to this project? Since I prefer to add test methods in source file, it could save many time to test.
Most of source editor support developers to run the code immediately, so in developing I always run my code.
Moreover, the reader can understand the source codes looking through those test methods. I believe those test codes are 
the best examples. Actually, even as the owner of source codes, we always would forget what our codes really do or 
to use them, reading the test methods could give us a clue. At least for me, it is quite useful.

For example, my source file would like the below:

    module FileLine
        def self.get(file_path, line_no)
            open(file_path) do |f|
                # tap depend on ruby > 1.9
                return f.each_line.tap{|enum| (line_no-1).times{enum.next}}.next
            end
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
    end

This project is inspired by Python minitest's some useful methods which could be used in test.
The below are useful functions:

    pt, ppt, ptl, pptl, flag_test

github: [https://github.com/jichen3000/testhelper](https://github.com/jichen3000/testhelper)

rubygems: [https://rubygems.org/gems/testhelper](https://rubygems.org/gems/testhelper)

-----------------------

### Author

Colin Ji <jichen3000@gmail.com>


### How to install

    gem install testhelper

### How to use

pt, print with title. This function will print variable name as the title.
<br>code:
    
    name = "Test Helper"
    # add a title 'name : ' automatically.
    name.pt()                       
    # or you can give a string as title.
    name.pt("It is a name:")

print result:

    name : Test Helper

    It is a name: Test Helper

ppt, pretty print with title. This function will print variable name as the title
in the first line, then pretty print the content of variable below the title.
<br>code:
    
    name = "Test Helper"
    # add a title 'name : ' automatically.
    name.ppt()
    
    # or you can give a string as title.
    name.ppt("It is a name:")

print result:

    name : 
    Test Helper

    It is a name: 
    Test Helper

ptl, print with title and code loction. This function just like pt, but will print
the code location at the first line.
And some editors support to go to the line of that file, such as Sublime2.
Notice: it will print a null line before the location information.
<br>code:
    
    name = "Test Helper"
    # add a title 'name : ' automatically.
    name.ptl()   
                        
    # or you can give a string as title.
    name.ptl("It is a name:")

print result:

    /Users/colin/work/testhelper/lib/testhelper.rb:84:in `<main>'
    name : Test Helper
    
    /Users/colin/work/testhelper/lib/testhelper.rb:89:in `<main>'
    It is a name: Test Helper

pptl, pretty print with title and code loction. This function just like ppt, but will print
the code location at the first line.
Notice: it will print a null line before the location information.
<br>code:
    
    name = "Test Helper"
    # add a title 'name : ' automatically.
    name.pptl()
    
    # or you can give a string as title.
    name.pptl("It is a name:")

print result:

    /Users/colin/work/testhelper/lib/testhelper.rb:84:in `<main>'
    name : 
    Test Helper
    
    /Users/colin/work/testhelper/lib/testhelper.rb:89:in `<main>'
    It is a name: 
    Test Helper

flag_test will print a message 'There are codes for test in this place!' with the code loction.
Notice: it will print a null line before the location information.
<br>code:

    flag_test()

    # add a title
    flag_test("for test")

print result:


    /Users/colin/work/testhelper/lib/testhelper.rb:84:in `<main>'
    There are test codes in this place!    


    /Users/colin/work/testhelper/lib/testhelper.rb:89:in `<main>'
    for test : There are test codes in this place!    
