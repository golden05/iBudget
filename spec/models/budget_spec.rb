require 'rails_helper'

RSpec.describe Budget do

  let(:travel_expense) { Budget.new(name = "travel_expense")  }
  let(:year_budget) { 10000 }
  let(:actual_amount_100) { 100 }
  let(:availability_budget) { Budget.new("availability_budget", amount = year_budget) }
  it 'a budget with name not initial amount not to availability' do
    expect(travel_expense.name).to eq("travel_expense")
    expect(travel_expense).not_to be_availability 
  end

  it 'a budget with opening balance and name to availability' do
    travel_expense.set_opening_balance(1000)
    expect(travel_expense).to be_availability
  end

  it 'a budget with opening balance = 0 not availability' do
    travel_expense.set_opening_balance
    expect(travel_expense).not_to be_availability
  end

  describe "Actual amount to availability budget" do
    let(:greater_actual_amount) { 10001 }
    let(:equal_actual_amount) { greater_actual_amount - 1 }

    it 'can availability to set actual amount' do
      expect(availability_budget).to be_availability
      availability_budget.set_actual_amount(actual_amount_100)
      expect(availability_budget.actual_amount).to eq(actual_amount_100)
    end

    it 'not availability not to set actual amount' do
      travel_expense.set_actual_amount(actual_amount_100)
      expect(travel_expense.actual_amount).to eq(0) 
    end

    it 'just set actual amount with 0 if set actual amount greater than budget' do
      availability_budget.set_actual_amount(greater_actual_amount)
      expect(availability_budget.actual_amount).to eq(0)
    end

    it 'can set actual amount if set actual greater and equal budget' do
      availability_budget.set_actual_amount(equal_actual_amount)
      expect(availability_budget.actual_amount).to eq(equal_actual_amount)
    end
  end

  describe "multi actual amounts" do
    let(:actual_amount_1000) { 1000 }

    it 'a budget has a actual amount' do
      availability_budget.actual_amounts << actual_amount_100
      expect(availability_budget.actual_amounts.size).to eq(1)
    end
  end
end
