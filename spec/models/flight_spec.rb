require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it { should belong_to :airline }
    it { should have_many :passenger_flights}
    it { should have_many(:passengers).through(:passenger_flights)}
  end

  describe 'validations' do
    it { should validate_presence_of :number}
    it { should validate_presence_of :date}
    it { should validate_presence_of :departure_city}
    it { should validate_presence_of :arrival_city}
  end
end