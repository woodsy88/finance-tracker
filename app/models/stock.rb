class Stock < ActiveRecord::Base
    
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    #looks through the stocks and finds a stock by its ticker ie. GOOG
    def self.find_by_ticker(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
    
    
    
    #looks up a stock and returns its ticker, name and last price in an object
    def self.new_from_lookup(ticker_symbol)
                           #this syntax is from the stock quote gem
        looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
        return nil unless looked_up_stock.name
        
        new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
        new_stock.last_price = new_stock.price
        new_stock
    end
    
    def price
       
       # if closing price is not nil, return the closing price
        closing_price = StockQuote::Stock.quote(ticker).close
        return "#{closing_price} (Closing)" if closing_price
        
        # if closing price is nil, then return opening price
        opening_price = StockQuote::Stock.quote(ticker).open
        return "#{opening_price} (Opening)" if opening_price
        
        # if neither opening, or closing price availble, return unavailable
        "Unavailable"
    
    end
end
