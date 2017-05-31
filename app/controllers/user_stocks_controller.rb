class UserStocksController < ApplicationController
  before_action :set_user_stock, only: [:show, :edit, :update, :destroy]

  # GET /user_stocks
  # GET /user_stocks.json
  def index
    @user_stocks = UserStock.all
  end

  # GET /user_stocks/1
  # GET /user_stocks/1.json
  def show
  end

  # GET /user_stocks/new
  def new
    @user_stock = UserStock.new
  end

  # GET /user_stocks/1/edit
  def edit
  end

  # POST /user_stocks
  # POST /user_stocks.json
  def create
   
              #the method new_from_lookup, find_by_ticker are all in the model file stock.rb
  
    #if the stock id is present and not an empty string
   if params[:stock_id].present?
                                  #uses the stock id and asscoiates it with the current user
      @user_stock = UserStock.new(stock_id: params[:stock_id], user: current_user)
   #if the stock id is not present 
   else
     #finds the stock is by its ticker (GOOG, twtr)
     stock = Stock.find_by_ticker(params[:stock_ticker])
              #differentitate which method to use to assign the stock to a user  
                #if the stock ticker it finds is valid
                if stock
                  @user_stock = UserStock.new(user: current_user, stock: stock)
                #the stock did not return a valid ticker
                else
                  stock = Stock.new_from_lookup(params[:stock_ticker])
            
            
                      #if this stock is valid and were able to save it to the stocks database, we create a new asssociation between the stock and the user
                      if stock.save
                        @user_stock = UserStock.new(user: current_user, stock: stock)
                      #else there is an error and the association could not be made because the stock could not be found
                      else
                        @user_stock = nil
                        flash[:error] = "stock is not available"
                      end
                end
   end
     
     
     
   
   

    respond_to do |format|
      if @user_stock.save
        format.html { redirect_to my_portfolio_path,
        notice: "Stock #{@user_stock.stock.ticker} was succesffuly added" }
        format.json { render :show, status: :created, location: @user_stock }
      else
        format.html { render :new }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stocks/1
  # PATCH/PUT /user_stocks/1.json
  def update
    respond_to do |format|
      if @user_stock.update(user_stock_params)
        format.html { redirect_to @user_stock, notice: 'User stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_stock }
      else
        format.html { render :edit }
        format.json { render json: @user_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stocks/1
  # DELETE /user_stocks/1.json
  def destroy
    @user_stock.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: 'Stock was succesfully removed from portfolio' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stock
      #@user_stock = UserStock.find(params[:id])
      @user_stock =current_user.user_stocks.where(stock_id:params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_stock_params
      params.require(:user_stock).permit(:user_id, :stock_id)
    end
end
