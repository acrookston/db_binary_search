require "spec_helper"

RSpec.describe DBBinarySearch do
  describe "#binary_search" do
    it "should find an exact matching object" do
      date = DateTime.parse("2017-01-07 00:00:00")
      slow_find    = Log.find_by(created_at: date)
      fast_find_id = Log.binary_search(:created_at, date)
      expect(fast_find_id).to eq(slow_find.id)
    end

    it "should find the closest matching object when no exact match" do
      date = DateTime.parse("2017-01-07 00:20:00")
      slow_find    = Log.find_by("created_at >= ?", date)
      fast_find_id = Log.binary_search(:created_at, date)
      expect(fast_find_id).to eq(slow_find.id)
    end

    it "should find lower bound if not given" do
      date = DateTime.parse("2017-01-07 00:00:00")
      log = double("log", id: 10)
      expect(log).to receive(:id)
      expect(Log).to receive(:first).and_return(log)
      Log.binary_search(:created_at, date)
    end

    it "should find upper bound if not given" do
      date = DateTime.parse("2017-01-07 00:00:00")
      log = double("log", id: 10)
      expect(log).to receive(:id)
      expect(Log).to receive(:last).and_return(log)
      Log.binary_search(:created_at, date)
    end
  end
end
