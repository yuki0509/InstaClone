class SearchPostsForm
  # DBを使用せずに、ActiveRecordと同じ挙動をする。（バリデーションやエラーメッセージの表示ができる）
  include ActiveModel::Model
  # attributeメソッドが使えるようになる。オブジェクトの属性を型指定して使えるようにすることができる。
  include ActiveModel::Attributes
  # body属性を追加する。ActiveRecordを使用した時と同じように扱えるので。bodyカラムとしても扱える。
  attribute :body, :string

  def search
    # ここでのbodyはSearchPostFormのオブジェクトの属性。attribute :bodyでオブジェクトにbody属性が追加された。
    scope = if body.present?
              # 重複なく投稿を取得する。この場合は、postオブジェクトのidが違うため重複してるオブジェクトはなく、allメソッドとしていることは同じ。
              Post.distinct.body_contain(body)
            else
              # 重複なく投稿を取得
              Post.distinct
            end
  end
end
