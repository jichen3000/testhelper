def mm()
    "mm"
end
if __FILE__ == $0
    require 'minitest/spec'
    require 'minitest/autorun'

    describe Array do
      before do
        @msg = "123"
      end
      it "can be created with no arguments" do
        @msg.must_equal("123")
        Array.new.must_be_instance_of Array
      end

      it "can be created with a specific size" do
        Array.new(10).size.must_equal 10
      end
      after do
        @msg = nil
      end
    end
    describe self do
        it "mm" do
            mm().must_equal "mm"
        end
    end
end