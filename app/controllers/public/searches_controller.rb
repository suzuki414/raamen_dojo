module Public
  class SearchesController < ApplicationController

    def search
      @model = params[:model]
      @content = params[:content]
      @method = params[:method]

      @ramen_noodles = []
      # 選択したモデルに応じて検索を実行
      if @model == "member"
        @members = Member.search_for(@content, @method).order(created_at: :desc).page(params[:page]).per(12)
      elsif @model == "ramen_noodle"
        @ramen_noodles = RamenNoodle.search_for(@content, @method).order(created_at: :desc).page(params[:page]).per(10)
      elsif @model == "tag"
        tag_ids = Tag.search_for(@content, @method).pluck(:id)
        tag_ramen_noodle_ids = RamenNoodleTag.where(tag_id: tag_ids).pluck(:ramen_noodle_id)
        @ramen_noodles = RamenNoodle.where(id: tag_ramen_noodle_ids).order(created_at: :desc).page(params[:page]).per(10)
      end
    end
  end
end
