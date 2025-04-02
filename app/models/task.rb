class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :status, type: String

  after_create  -> { broadcast_creation() }
  after_update  -> { broadcast_updation() }
  after_destroy -> { broadcast_deletion() }

  private

  def broadcast_creation()
    Turbo::StreamsChannel.broadcast_append_to( "tasks",
      target: "#{self.status}_tasks",
      partial: "tasks/task",
      locals: { task: self }
    )

    Turbo::StreamsChannel.broadcast_replace_to("tasks_count",
      target: "#{self.status}_tasks_count",
      html: Task.where(status: self.status).count.to_s
    )

    # Turbo::StreamsChannel.broadcast_replace_to("tasks_count",
    #   target: "notification",
    #   partial: "tasks/notification", locals: {content: "Task was successfully created."}
    # )
  end
  def broadcast_updation()
    Turbo::StreamsChannel.broadcast_replace_to "tasks",
      target: "task_#{self.id.to_s}",
      partial: "tasks/task",
      locals: { task: self }
  end
  def broadcast_deletion()
    Turbo::StreamsChannel.broadcast_replace_to "tasks",
      target: "task_#{self.id.to_s}"

    Turbo::StreamsChannel.broadcast_replace_to "tasks_count",
      target: "#{self.status}_tasks_count",
      html: Task.where(status: self.status).count.to_s
  end
end
