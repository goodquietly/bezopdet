ActiveAdmin.register TrainingProgram do
  permit_params :title, :pdf, :published

  scope :all
  scope :published
  scope :unpublished

  controller do
    def create
      @training_program = TrainingProgram.new(permitted_params[:training_program])

      super
      return unless @training_program.save

      ChildProgramBuilderService.call(@training_program)
    end

    def update
      @training_program = TrainingProgram.find(params[:id])

      super
      return unless @training_program.update(permitted_params[:training_program])

      ChildProgramBuilderService.call(@training_program)
    end
  end

  form do |f|
    inputs 'Характеристики' do
      f.input :title
      f.input :pdf, as: :file
      f.input :published
    end
    actions
  end

  action_item :publish, only: :show do
    unless training_program.published?
      link_to 'Опубликовать', publish_admin_training_program_path(training_program),
              method: :put
    end
  end

  action_item :unpublish, only: :show do
    if training_program.published?
      link_to 'Снять с публикации', unpublish_admin_training_program_path(training_program),
              method: :put
    end
  end

  member_action :publish, method: :put do
    program = TrainingProgram.find(params[:id])
    program.update(published: true)
    ChildProgramBuilderService.call(program)
    redirect_to admin_training_program_path(program)
  end

  member_action :unpublish, method: :put do
    program = TrainingProgram.find(params[:id])
    program.update(published: false)
    ChildProgramBuilderService.call(program)
    redirect_to admin_training_program_path(program)
  end
end
