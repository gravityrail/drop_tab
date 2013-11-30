class EntriesController < ApplicationController
  def index
    #@entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    entry_params = params[:entry]
    entry_params[:original_file_name] = params[:filename]
    entry_params[:content_type] = params[:filetype]
    entry_params[:original_url] = CGI.unescape(entry_params[:original_url]) # correct a dumb JS error
    @entry = Entry.create(entry_params)
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(params[:entry])
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to entries_url
  end
end
