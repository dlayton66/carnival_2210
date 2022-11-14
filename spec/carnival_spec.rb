require './lib/carnival'

RSpec.describe Carnival do
  let(:carnival) { Carnival.new(7) }

  it 'exists and has attributes' do
    expect(carnival).to be_a Carnival
    expect(carnival.rides).to eq([])
  end
end