class TweetsController < ApplicationController
  
  before_filter :login_required, :only => [:new, :create]
  
  def index
    @tweet = Tweet.new
    @tweets = if current_user
       current_user.feed
      else 
        Tweet.all
      end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tweets }
    end
  end

  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tweet }
    end
  end

  def create
    @tweet = current_user.tweets.new(params[:tweet])

    respond_to do |format|
      if @tweet.save
        format.html {redirect_to(tweets_path, :notice => 'Tweet was successfully created.') }
        format.js
      else
        format.html {render :action => "new"}
        format.js do
          render :update do |page|
            page.alert "Your tweet could not be saved. #{@tweet.errors.full_messages}. Please try again"
          end
        end
      end
    end
  end

  # # GET /tweets/1
  # # GET /tweets/1.xml
  # def show
  #   @tweet = Tweet.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @tweet }
  #   end
  # end


  # # GET /tweets/1/edit
  # def edit
  #   @tweet = Tweet.find(params[:id])
  # end


  # # PUT /tweets/1
  # # PUT /tweets/1.xml
  # def update
  #   @tweet = Tweet.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @tweet.update_attributes(params[:tweet])
  #       format.html { redirect_to(@tweet, :notice => 'Tweet was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /tweets/1
  # # DELETE /tweets/1.xml
  # def destroy
  #   @tweet = Tweet.find(params[:id])
  #   @tweet.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(tweets_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
