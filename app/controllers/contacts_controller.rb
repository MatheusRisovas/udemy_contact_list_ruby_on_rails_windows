class ContactsController < ApplicationController
  before_action :require_logged_in_user
  before_action :set_contact, only: [:show,:edit,:update,:destroy]

  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def show
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contato foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contato foi editado com sucesso.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contato foi excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :phone)
    end
end
