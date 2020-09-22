class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      #null:falseを入れる
      t.references :user, foreign_key: true

      t.timestamps
      #  add_index :いつ、だれか投稿したかをわかるようにする。目次を作る
    end
    add_index :microposts, [:user_id, :created_at] #記述の場所間違えない
  end
end
