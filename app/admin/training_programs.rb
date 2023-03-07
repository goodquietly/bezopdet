ActiveAdmin.register TrainingProgram do
  permit_params :title, :url, :published

  scope :all
  scope :published
  scope :unpublished

  form do |_f|
    inputs 'Details' do
      input :title
      input :url
      input :published
    end
    actions
  end

  action_item :publish, only: :show do
    unless training_program.published?
      link_to 'Publish', publish_admin_training_program_path(training_program),
              method: :put
    end
  end

  action_item :unpublish, only: :show do
    if training_program.published?
      link_to 'Unpublish', unpublish_admin_training_program_path(training_program),
              method: :put
    end
  end

  member_action :publish, method: :put do
    program = TrainingProgram.find(params[:id])
    program.update(published: true)
    redirect_to admin_training_program_path(program)
  end

  member_action :unpublish, method: :put do
    program = TrainingProgram.find(params[:id])
    program.update(published: false)
    redirect_to admin_training_program_path(program)
  end
end
