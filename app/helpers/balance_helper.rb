module BalanceHelper

  def balance_span(balance)
    span_class = balance < 0 ? "neg-balance" : "non-neg-balance"
    "<span class='#{span_class}'>#{balance.abs}</span>".html_safe
  end
end