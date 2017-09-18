# Rails で~~ファイル~~画像ファイルアップロード：2017

## 環境

- Ruby on Rails 5.1.3
- Ruby 2.3.3

## 目的

- 2017年、Rails でファイルアップロードを作るとしたらどうするんだろう？と考えるための試作品
- Rails に限定してみた（他のフレームワークなら...というのはあるかもしれない）

## gem でやる前に


## UI/UX

## 先？

- S3 にファイルをアップロードしたら Lamda で処理

## TODO

- [ ] show で画像を表示する
- [ ] 画像にコメントを書く
- [ ] 編集できるようにする
- [ ] ダイレクトアップロード
  - es6で行うのでbabelの用意
  - Capybara でドラッグ&ドロップのテスト
      - http://qiita.com/gymnstcs/items/0852a06d735dac748296
      - http://ria10.hatenablog.com/entry/20131230/1388372110
- [ ] S3にファイルを置く
  - [ ] S3へのアップロード設定
  - [ ] S3のアップロードのテスト
  - [ ] ファイル名の課題
- [ ] 「同意する」check button を用意する
- [x] フォーム内で画像のプレビューをする
  - [x] 入力画面
  - [x] 確認画面
  - [x] テスト
- [ ] 確認画面を用意する
   - [x] 画像の保存
   - [ ] テスト
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

### 画像のモデルとActionDispatch::Http::UploadedFile

- 画像のモデルがありつつ、ファイル自体は ActionDispatch::Http::UploadedFile にある
  - 2つで1つになる
  - 取り扱いがややこしい

### must exit

- Rails 5 から入った
- アソシエーションが設定されている場合、require が必須になる

```ruby
class PostImage < ApplicationRecord
  belongs_to :user, optional: true
end
```

### どのタイミングでファイルを保存するか？

- 確認画面にいく時点で保存してしまう。問題なければそのまま
- S3であればディスク容量をあまり考えない
  - 最初はtmpというディレクトリに保存するけれど、完了画面時にディレクトリ移動するとか
  - /tmp というディレクトリは30日後に削除する、という設定が S3 では可能

## 参考URL

### willnet

- http://blog.willnet.in/entry/2017/08/21/093000

### ダイレクトアップロード？

- http://qiita.com/yuku_t/items/40b7daf018d3dab48974
- http://qiita.com/usutani/items/37988abd0873fd491625
- https://www.designedbyaturtle.co.uk/2015/direct-upload-to-s3-using-aws-signature-v4-php/
- http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/HLTrackProgressMPUJava.html

### Refile

- https://github.com/refile/refile
- http://blog.willnet.in/entry/2015/01/05/021926
- http://qiita.com/takeyuweb/items/526df5f456aefa2d3c7f

### Shrine

- http://qiita.com/okuramasafumi/items/488b535ad8889ef22b72
- http://qiita.com/yuku_t/items/40b7daf018d3dab48974
- http://qiita.com/alpaca_taichou/items/6ea2b88bee6ce43061dd
