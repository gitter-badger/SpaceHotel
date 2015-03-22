class AddImageAttachmentToRoomAndArticle < ActiveRecord::Migration
  def change

    add_attachment :rooms, :image
    add_attachment :articles, :image
  end
end
