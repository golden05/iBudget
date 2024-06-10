class Budget

  attr_accessor :name, :opening_balance, :availability 
  attr_accessor :actual_amount
  attr_accessor :actual_amounts

  def initialize(name, amount=0)
    @name = name
    @availability = false
    set_opening_balance(amount)
    @actual_amounts = []
  end

  def availability?
    @availability
  end

  def set_opening_balance(amount=0)
    if amount > 0
      @opening_balance = amount
      @availability =true
    else
      @availability = false
    end
  end

  def set_actual_amount(amount=0)
    if availability && amount <= @opening_balance
      @actual_amount = amount
    else
      @actual_amount = 0
    end
    @actual_amounts << @actual_amount
  end
end
