class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :status, type: String

  after_create  -> { broadcast_creation("This article is newly created.") }
  after_update  -> { broadcast_updation("An article was updated.") }
  after_destroy -> { broadcast_deletion("An article was deleted.") }

  private

  def broadcast_creation(message)
    Turbo::StreamsChannel.broadcast_append_to( "tasks",
      target: "#{self.status}_tasks",
      partial: "tasks/task",
      locals: { task: self,  }
    )
  end
  def broadcast_updation(message)
    Turbo::StreamsChannel.broadcast_replace_to "tasks",
      target: "task_#{self.id.to_s}",
      partial: "tasks/task",
      locals: { task: self }
  end
  def broadcast_deletion(message)
    Turbo::StreamsChannel.broadcast_replace_to "tasks",
      target: "task_#{self.id.to_s}"
  end
end
