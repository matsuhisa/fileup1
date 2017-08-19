# Rails でファイルアップロード：2017

## 環境

- Ruby on Rails 5.1.3
- Ruby 2.3.3

## 目的

- 2017年、Rails でファイルアップロードを作るとしたらどうするんだろう？と考えるための試作品
- Rails に限定してみた（他のフレームワークなら...というのはあるかもしれない）

## TODO

- [ ] show で画像を表示する
- [ ] 画像にコメントを書く
- [ ] 編集できるようにする

- [ ] ダイレクトアップロード
  - es6で行うのでbabelの用意
- [ ] S3にファイルを置く
  - [ ] S3へのアップロード設定
  - [ ] S3のアップロードのテスト
- [ ] フォーム内で画像のプレビューをする
  - 入力画面
  - 確認画面
- [ ] 「同意する」check button を用意する
- [ ] 確認画面を用意する
- [x] 入力エラーの対応
  - [x] 入力エラー画面でも画像は保持する
  - [x] 入力でエラーがあった時のテスト
- [x] form_object を使う
  - テストの追加をする
  - [x] userだけの時のテスト
  - [x] 画像も一緒の時のテスト
- [x] form_with を使う
- [x] テストを書く
- [x] Public にアップロードしてみる

## 気づきメモ

### form_object の時

- PostImage クラスと ActionDispatch::Http::UploadedFile をどう扱うか？
  - params では、ActionDispatch::Http::UploadedFile を扱える
  - form_object ではどのように扱うのかがいいのか？
  - uploaded_files というのがある想定でやってみた

### ActionDispatch::Http::UploadedFile とエラー画面、確認画面

- もしかして、RailsGirls で同じようなことしていない？
  - http://railsgirls.jp/app
  - http://blog.livedoor.jp/sasata299/archives/52006066.html
    - え？そうなの
  - https://tech.recruit-mp.co.jp/server-side/niche-rails-tips/

### must exit

- Rails 5 から入った
- アソシエーションが設定されている場合、require が必須になる

```ruby
class PostImage < ApplicationRecord
  belongs_to :user, optional: true
end
```

## 参考URL

### ダイレクトアップロード？

- http://qiita.com/yuku_t/items/40b7daf018d3dab48974

### Refile

- https://github.com/refile/refile
- http://blog.willnet.in/entry/2015/01/05/021926
- http://qiita.com/takeyuweb/items/526df5f456aefa2d3c7f

### Shrine

- http://qiita.com/okuramasafumi/items/488b535ad8889ef22b72
- http://qiita.com/yuku_t/items/40b7daf018d3dab48974
- http://qiita.com/alpaca_taichou/items/6ea2b88bee6ce43061dd
