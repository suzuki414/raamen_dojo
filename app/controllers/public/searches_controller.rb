module Public
  class SearchesController < ApplicationController

    def search
      @model = params[:model]
      @content = params[:content]
      @method = params[:method]

      # 選択したモデルに応じて検索を実行
      if @model == "member"
        @records = Member.search_for(@content, @method)
      elsif @model == "ramen_noodle"
        @records = RamenNoodle.search_for(@content, @method)
      elsif @model == "tag"
        @tag = Tag.search_for(@content, @method)
        @records = @tag.ramen_noodles
      end
    end

    def search_tag
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      #検索されたタグに紐づく投稿を表示
      @ramen_noodles = @tag.ramen_noodles
    end
  end
end
