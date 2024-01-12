# アプリケーション名

ToProgress


# アプリケーション概要

塾で利用するアプリで、生徒の成績管理と質問チャットができる。


# URL

https://toprogress.onrender.com


# テスト用アカウント

- Basic認証ID：tom
- Basic認証パスワード：2222
- メールアドレス（講師）：test@teacher
- パスワード（講師）：111111
- メールアドレス（中１）：test@student
- パスワード（中１）：111111


# 利用方法

## 成績登録
- ユーザーの学年が講師の場合
  1. ヘッダーの生徒一覧ボタンから生徒一覧ページに移動する
  1. 登録する生徒を選択し、成績一覧ページに移動する
  1. 成績の名前と分類を入力し、登録ボタンで登録する
  1. 教科名、点数、順位などを入力し、保存ボタンで保存する
- ユーザーの学年が中１〜高３の場合
  1. ヘッダーの成績一覧ボタンから成績一覧ページに移動する
  1. 成績の名前と分類を入力し、登録ボタンで登録する
  1. 教科名、点数、順位などを入力し、保存ボタンで保存する

## 成績管理
1. 成績一覧ページから閲覧・編集したい成績を選択する
1. 編集ボタンから科目を追加・編集するか、コメントの投稿を行う

## 質問チャット
1. ヘッダーの質問一覧ボタンから質問一覧ページに移動する
1. 質問一覧から選択する、もしくはユーザーの学年が中１〜高３の場合、質問のタイトルを入力して質問を作成する
1. メッセージを入力し、送信ボタンで送信する
1. 解決したら質問を閉じるボタンでチャットを終了する


# アプリケーションを作成した背景

現在塾講師の仕事をしていて、生徒の特に自宅学習時のモチベーションが上がらない、という課題を抱えていた。
課題を分析した結果、テスト結果や成績に対する先生側のアクションがないことや、不明点を次の授業まで残してしまうことが原因であると仮説を立てた。
この課題を解決するために、成績を管理してコメントができる機能と、質問チャット機能のあるアプリケーションを開発することにした。


# 洗い出した要件

[用件定義シート](https://docs.google.com/spreadsheets/d/1nHw2os_5pjP5qvSa_tRxzUgwIGajZcDYpUa_ugUmjJQ/edit#gid=982722306)


# 実装した機能についての画像やGIFおよびその説明

- ユーザー管理
  - ユーザー登録機能<br>
    登録時に学年を選択する。講師かそれ以外（生徒）かで利用できる機能の範囲が変わる。学年はヘッダーに表示される。<br>
    [![Image from Gyazo](https://i.gyazo.com/a112cd1b32568e0a70b4dac929d29116.gif)](https://gyazo.com/a112cd1b32568e0a70b4dac929d29116)

- 成績管理
  - 成績を閲覧する機能
    - ユーザーの学年が講師の場合、全生徒の成績を閲覧できる<br>
    [![Image from Gyazo](https://i.gyazo.com/f2a436de5b4d3c66b56f0a27d84793ee.gif)](https://gyazo.com/f2a436de5b4d3c66b56f0a27d84793ee)
    - ユーザーの学年が中１〜高３の場合、自身の成績を閲覧できる<br>
    [![Image from Gyazo](https://i.gyazo.com/816028e2f0d0555740617e74e6c3a427.gif)](https://gyazo.com/816028e2f0d0555740617e74e6c3a427)

  - 成績を登録する機能<br>
    登録時に分類を選択する。一覧ページでは分類ごとに表示される。<br>
    [![Image from Gyazo](https://i.gyazo.com/02d4fddd4af773bad33a9dd2edbe2e69.gif)](https://gyazo.com/02d4fddd4af773bad33a9dd2edbe2e69)

  - 科目を登録、編集、削除する機能<br>
    [![Image from Gyazo](https://i.gyazo.com/2070bc423bca15b18fb9e0dac06b9fb6.gif)](https://gyazo.com/2070bc423bca15b18fb9e0dac06b9fb6)

  - 成績にコメントする機能<br>
    [![Image from Gyazo](https://i.gyazo.com/3d0cfb20c2218e0faf6c8de008692763.gif)](https://gyazo.com/3d0cfb20c2218e0faf6c8de008692763)

- 質問管理
  - 質問を閲覧する機能
    - ユーザーの学年が講師の場合、全生徒の質問を閲覧できる<br>
    [![Image from Gyazo](https://i.gyazo.com/74ef287af4454339727b32e204bfb14d.gif)](https://gyazo.com/74ef287af4454339727b32e204bfb14d)
    - ユーザーの学年が中１〜高３の場合、自身の質問を閲覧できる<br>
    [![Image from Gyazo](https://i.gyazo.com/ed2f33f4915b198d208b4aec80ceb6be.gif)](https://gyazo.com/ed2f33f4915b198d208b4aec80ceb6be)

  - 質問を作成する機能<br>
    ユーザーの学年が中１〜高３の場合のみ作成できる。<br>
    [![Image from Gyazo](https://i.gyazo.com/693273eaf7891ff23db4b5a6c0861b62.gif)](https://gyazo.com/693273eaf7891ff23db4b5a6c0861b62)

  - 質問チャット機能<br>
  [![Image from Gyazo](https://i.gyazo.com/872d436b536293ec86e11a00a77a73b3.gif)](https://gyazo.com/872d436b536293ec86e11a00a77a73b3)
    - 解決したらチャットを終了させることができ、また再開させることもできる<br>
    [![Image from Gyazo](https://i.gyazo.com/7d0a3a93559738ceaccdf49efbff47da.gif)](https://gyazo.com/7d0a3a93559738ceaccdf49efbff47da)
    - 画像を投稿できる<br>
    [![Image from Gyazo](https://i.gyazo.com/b6dcdd4ffbbcf532cf12d6964107ec50.gif)](https://gyazo.com/b6dcdd4ffbbcf532cf12d6964107ec50)


# 実装予定の機能

- 実装予定<br>
  - 講師側からお知らせ等のコンテンツを作成、閲覧できる機能
- 今後の課題<br>
  - 教室ネットワークに繋がなければユーザー新規登録をできなくする
  - データの暗号化処理


# データベース設計
[![Image from Gyazo](https://i.gyazo.com/1ee493d396784cd4ef35857f5d4fb153.png)](https://gyazo.com/1ee493d396784cd4ef35857f5d4fb153)


# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/fe19ec56f2551348b36760981fe80b66.png)](https://gyazo.com/fe19ec56f2551348b36760981fe80b66)


# 開発環境

Ruby/Ruby on Rails/MySQL/PostgreSQL/Github/Visual Studio Code


# ローカルでの動作方法

以下のコマンドを順に実行。 <br>
% git clone https://github.com/tomcharo/ToProgress <br>
% cd ToProgress <br>
% bundle install <br>
% rails db:migrate <br>
% rails s


# 工夫したポイント

講師であれば全生徒の成績・質問を管理できるが、生徒であれば自身の成績・質問のみ管理できるといったように、ユーザーの属性によって利用できる機能の範囲が変わるように実装した。