module Public
  class SearchesController < ApplicationController

    def search
      @model = params[:model]
      @content = params[:content]
      @method = params[:method]

      @ramen_noodles = []
      # 選択したモデルに応じて検索を実行
      if @model == "member"
        @members = Member.search_for(@content, @method)
      elsif @model == "ramen_noodle"
        @ramen_noodles = RamenNoodle.search_for(@content, @method)
      elsif @model == "tag"
        tag_ids = Tag.search_for(@content, @method).pluck(:id)
        tag_ramen_noodle_ids = RamenNoodleTag.where(tag_id: tag_ids).pluck(:ramen_noodle_id)
        @ramen_noodles = RamenNoodle.where(id: tag_ramen_noodle_ids)
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