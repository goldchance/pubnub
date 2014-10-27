class Message < ActiveRecord::Base
  after_create :remove_old

  private

  def remove_old
    while Message.all.size > 20
      Message.first.destroy
    end
  end
end
