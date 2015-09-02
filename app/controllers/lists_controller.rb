class ListsController < ApplicationController
  def index
    @lists = List.all.reverse_order
  end

  def create
    params[:urls].reverse.each do |url|
      List.find_or_create_by(url: url)
    end

    render text: 'successful'
  end
end
