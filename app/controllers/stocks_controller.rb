class StocksController < ApplicationController
   
  
   def search
        
       #searches for stock and stores it in an instance variable. this method finds a stock
        if params[:stock]
                        #find by ticker defined in stock.rb
        @stock = Stock.find_by_ticker(params[:stock])
        # ||= means that if it is already looked up, it will be stored in @stock. other wise is runs Stock.new_from_lookup to find it
        @stock ||= Stock.new_from_lookup(params[:stock])
                        #new from lookup defined in stock.rb
        end
        
        #if there is a stock instance variable, we do this. this method displays the found stock
        if @stock
            #good way to test if its working
            #render json: @stock
            render partial: 'lookup'
        else
            render status: :not_found, nothing: true
        end
   end 
    
end