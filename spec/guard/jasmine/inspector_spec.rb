require 'spec_helper'

describe Guard::Jasmine::Inspector do
  before do
    File.stub(:exists?) do |file|
      ['spec/javascripts/a_spec.js.coffee', 'spec/javascripts/b_spec.js', 'c_spec.coffee'].include?(file)
    end
  end

  subject { Guard::Jasmine::Inspector }

  describe 'clean' do
    it 'allows the Jasmine spec dir' do
      subject.clean(['spec/javascripts', 'spec/javascripts/a.js.coffee']).should == ['spec/javascripts']
    end

    it 'removes duplicate files' do
      subject.clean(['spec/javascripts/a_spec.js.coffee', 'spec/javascripts/a_spec.js.coffee']).should == ['spec/javascripts/a_spec.js.coffee']
    end

    it 'remove nil files' do
      subject.clean(['spec/javascripts/a_spec.js.coffee', nil]).should == ['spec/javascripts/a_spec.js.coffee']
    end

    it 'removes files that are no javascript specs' do
      subject.clean(['spec/javascripts/a_spec.js.coffee',
                     'spec/javascripts/b_spec.js',
                     'app/assets/javascripts/a.js.coffee',
                     'b.txt',
                     'c_spec.coffee']).should == ['spec/javascripts/a_spec.js.coffee', 'spec/javascripts/b_spec.js', 'c_spec.coffee']
    end

  end
end
