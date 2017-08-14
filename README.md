# Rails でファイルアップロード：2017

## 環境

- Ruby on Rails 5.1.3
- Ruby 2.3.3

## 目的

- 2017年、Rails でファイルアップロードを作るとしたらどうするんだろう？と考えるための試作品
- Rails に限定してみた（他のフレームワークなら...というのはあるかもしれない）

## TODO

- [ ] 画像にコメントを書く
- [ ] S3にファイルを置く
- [ ] show で画像を表示する
- [ ] フォーム内で画像のプレビューをする
  - 入力画面
  - 確認画面
- [ ] 編集できるようにする
- [ ] 確認画面を用意する
- [ ] 「同意する」check button を用意する
- [ ] form_object を使う
  - テストの追加をする
  - [ ] userだけの時のテスト
  - [ ] 画像も一緒の時のテスト
  - [ ] 入力でエラーがあった時のテスト
- [x] form_with を使う
- [x] テストを書く
- [x] Public にアップロードしてみる

## 気づきメモ

### form_object の時

- PostImage クラスと ActionDispatch::Http::UploadedFile をどう扱うか？
  - params では、ActionDispatch::Http::UploadedFile を扱える
  - form_object ではどのように扱うのかがいいのか？
  - uploaded_files というのがある想定でやってみた

