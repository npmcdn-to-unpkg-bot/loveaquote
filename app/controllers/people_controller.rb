class PeopleController < ApplicationController
  before_action :set_person, only: [:show]
  
  def index
    @people = Person.popular.published.order(name: "ASC").group_by{|a| a.name[0]}
    @title = "Person List"
    @canonical = "#{people_url}"
  end
  
  def alphabet
    @alphabet = params[:alphabet].upcase
    @people = Person.by_alphabet(@alphabet).published.order(name: "ASC")
  end

  def show
    @quotes = @person.all_quotes.order(total_share_count: :desc).order(text: :asc).page params[:page]
    render layout: "person"
  end
  
  private
  
  def set_person
    @person = Person.published.find_by_slug(params[:id])
    redirect_to serve_404_url unless @person
  end
end
