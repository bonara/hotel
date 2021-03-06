require_relative 'spec_helper'

describe 'DateRange class' do
  describe 'initialize' do
    before do
      start_date = "2019-01-20"
      end_date = "2019-01-25"
      @dateRange = Hotel::DateRange.new(start_date, end_date)
    end 
    it "is an instance of DateRange" do
      expect(@dateRange).must_be_kind_of Hotel::DateRange
    end

    it "raises an error for and invalid end time" do 
      start_date = "2019-01-20"
      end_date = "2019-01-10"
      expect do
        Hotel::DateRange.new(start_date, end_date)
      end.must_raise ArgumentError
    end

    it "converts dates to a range" do
      expect(@dateRange.to_range).must_be_kind_of Range
    end

    it "returns true if date is included in the range" do
      expect(@dateRange.is_included?("2019-01-22")).must_equal true
    end

    it "returns false if date isn't included in the range" do
      expect(@dateRange.is_included?("2019-01-25")).must_equal false
    end
    
    it "returns false when date equals the last date of the range" do
      expect(@dateRange.is_included?("2019-01-25")).must_equal false
    end

    it "returns true when the date range overlaps the range" do
      expect(@dateRange.is_overlapped?("2019-1-20","2019-1-25")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-10","2019-1-22")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-22","2019-1-29")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-10","2019-1-25")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-20","2019-1-29")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-22","2019-1-24")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-10","2019-1-29")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-21","2019-1-25")).must_equal true
      expect(@dateRange.is_overlapped?("2019-1-20","2019-1-23")).must_equal true
    end
   
    it "returns false when the date range doesn't overlap the range" do
      expect(@dateRange.is_overlapped?("2019-1-10","2019-1-15")).must_equal false
      expect(@dateRange.is_overlapped?("2019-1-26","2019-2-10")).must_equal false
      expect(@dateRange.is_overlapped?("2019-1-10","2019-1-20")).must_equal false
      expect(@dateRange.is_overlapped?("2019-1-25","2019-1-29")).must_equal false
    end

    it "returns the correct date count" do
      expect(@dateRange.date_count).must_equal 5
    end
  end
end
