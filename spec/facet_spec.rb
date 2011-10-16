require 'spec_helper'

describe Facet do
  describe ".parse" do
    context "with a correctly formatted facet" do
      before do
        @result = Facet.parse(<<-EOD)
          facet normal 0.0 0.0 -1.0
          outer loop
          vertex 16.5 0.0 -0.75
          vertex 0.0 -9.5 -0.75
          vertex 0.0 0.0 -0.75
          endloop
          endfacet
        EOD
      end
      
      it "should return a facet object" do
        @result.should be_a Facet
      end
      
      it "should return a facet with 3 vertices" do
        @result.vertices.length.should == 3
      end
      
      it "should return a facet with vertices of type Vertex" do
        @result.vertices.each do |vertex|
          vertex.should be_a Vertex
        end
      end
      
      it "should return a facet with a normal of type Vector" do
        @result.normal.should be_a Vector
      end
      
      it "should correctly set the normal values" do
        @result.normal.x.should == 0
        @result.normal.y.should == 0
        @result.normal.z.should == -1
      end
      
      it "should correctly set the values for the first vertex" do
        @result.vertices[0].x.should == 16.5
        @result.vertices[0].y.should == 0
        @result.vertices[0].z.should == -0.75
      end
      
      it "should correctly set the values for the second vertex" do
        @result.vertices[1].x.should == 0
        @result.vertices[1].y.should == -9.5
        @result.vertices[1].z.should == -0.75
      end
      
      it "should correctly set the values for the third vertex" do
        @result.vertices[2].x.should == 0
        @result.vertices[2].y.should == 0
        @result.vertices[2].z.should == -0.75
      end
    end
  end
  
  describe "#to_s" do
    it "should return the string representation for a facet" do
      facet = Facet.new
      facet.normal = Vector.new(0, 0, 1)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      facet.vertices << Point.new(1, 2, 3)
      
      expected_string  = "facet normal 0.0 0.0 1.0\n"
      expected_string += "outer loop\n"
      expected_string += facet.vertices[0].to_s + "\n"
      expected_string += facet.vertices[1].to_s + "\n"
      expected_string += facet.vertices[2].to_s + "\n"
      expected_string += "endloop\n"
      expected_string += "endfacet\n"
      
      facet.to_s.should == expected_string
    end
  end
end