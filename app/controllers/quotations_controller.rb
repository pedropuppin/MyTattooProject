class QuotationsController < ApplicationController

  def index
    @quotations = Quotation.all
  end

  def show
    @quotations = Quotation.find(params[:id])
  end

  def new
    @quotation = Quotation.new
  end
