require 'helper'
require 'tmpdir'

class TestReadMetrics < Test::Unit::TestCase

  context "ReadMetrics" do

    setup do
      query = File.join(File.dirname(__FILE__), 'data',
                        'sorghum_transcript.fa')
      assembly = Transrate::Assembly.new(query)
      @read_metrics = Transrate::ReadMetrics.new(assembly)
    end

    should "setup correctly" do
      assert @read_metrics
    end

    should "calculate read mapping statistics" do
      left = File.join(File.dirname(__FILE__), 'data', 'left.fastq')
      right = File.join(File.dirname(__FILE__), 'data', 'right.fastq')
      Dir.mktmpdir do |tmpdir|
        Dir.chdir tmpdir do
          @read_metrics.run(left, right)
          stats = @read_metrics.read_stats
          p stats
          assert @read_metrics.has_run
          assert_equal 7763, stats[:num_pairs], 'number of read pairs'
          assert_equal 7739, stats[:total_mappings], 'number mapping'
          assert_equal 99.69, stats[:percent_mapping].round(2),
                       'percent mapping'
          assert_equal 7739, stats[:good_mappings], 'good mapping'
          assert_equal 99.69, stats[:pc_good_mapping].round(2),
                       'percent good mapping'
          assert_equal 0, stats[:bad_mappings], 'bad mapping'
        end
      end
    end

    should "find read pairs that support scaffolding" do
    end

    should "count per-base coverage" do
    end

    should "find median coverage" do
    end

    should "identify contigs with at least one uncovered base" do
    end

    should "identify contigs with coverage <1" do
    end

    should "identify contigs with coverage <10" do
    end

  end

end
