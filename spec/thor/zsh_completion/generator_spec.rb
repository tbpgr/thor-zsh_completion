require "spec_helper"

describe Thor::ZshCompletion::Generator do
  let(:thor) {
    nest2 = Class.new(Thor) do
      desc "baz", "Description of baz"
      def baz
        p options
        puts "baz"
      end
    end

    nest1 = Class.new(Thor) do
      desc "bar", "Description of bar"
      def bar
        p options
        puts "bar"
      end

      desc "nest2", "Description of nest2"
      subcommand "nest2", nest2
    end

    main = Class.new(Thor) do
      class_option :global, description: "Global option"

      desc "foo", "Description of foo"
      def foo
        p options
        puts "foo"
      end

      desc "nest1", "Description of nest1"
      subcommand "nest1", nest1
    end
  }

  let(:expected) { File.read("#{File.dirname(__FILE__)}/generator_spec.zsh") }

  subject { Thor::ZshCompletion::Generator.new(thor, "generator_spec").generate }

  it { should eq expected }
end

