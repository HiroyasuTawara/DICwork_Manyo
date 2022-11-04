# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 10
#1ページあたりの表示件数(デフォルトは25レコード）

  # config.max_per_page = nil
#ページあたりの最大表示件数(デフォルトはnil。つまり無限）

  config.window = 4
#現在のページから、左右何ページ分のリンクを表示させるか(デフォルトは4件)

  # config.outer_window = 0
#最初(First)と最後(Last)のページから、左右何ページ分のリンクを表示させるか(デフォルトは0件)

  # config.left = 0
#最初(First)のページから、何ページ分のリンクを表示させるか(デフォルトは0件)

  # config.right = 0
#最終(Last)ページから、何ページ分のリンクを表示させるか(デフォルトは0件)

  # config.page_method_name = :page
#モデルに追加されるページ番号を指定するスコープの名前:page by default

  # config.param_name = :page
#ページ番号を渡すために使用するパラメータ名(デフォルトは:page)
#↑Board.page(params[:page])のようにparamsメソッドで取得できる。

  # config.max_pages = nil
#最大ページ数(デフォルトはnil）

  # config.params_on_first_page = false
#最初のページでparamsを無視しない
end