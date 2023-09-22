class ContactsController < ApplicationController
  before_action :set_contact, only: %i[destroy]

  def create
    @new_contact = child.contacts.build(contact_params)
    authorize @new_contact

    if @new_contact.save
      redirect_back_or_to child, notice: 'Контакт успешно сохранен!'
    else
      render 'children/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy

    redirect_back_or_to child, notice: 'Контакт удален.'
  end

  private

  def child
    @child ||= Child.find(params[:child_id])
  end

  def set_contact
    @contact = authorize child.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:full_name, :phone_number, :role)
  end
end