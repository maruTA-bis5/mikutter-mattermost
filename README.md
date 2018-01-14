# mikutter-mattermost
Mattermost for mikutter

# これは何?
[mikutter](http://mikutter.hachune.net)でMattermostを利用するためのプラグイン(の予定)

# インストール方法
1. 以下のコマンドをコンソールで実行します
```
$ mkdir -p ~/.mikutter/plugin && cd ~/.mikutter/plugin
$ git clone https://github.com/maruTA-bis5/mikutter-mattermost.git
```
2. 依存するGemをインストールするため、mikutterのインストールディレクトリに移動し以下のコマンドを実行します
```
$ bundle install
```
3. mikutterを再起動してください

# アカウントの設定
1. mikutterの設定を開きます
1. アカウント情報を選択し、「Add」をクリック
1. `Select world`は`Mattermost`を選択し、OK
1. MattermostのURL(`https://your-mattermost-server.com`)と認証に使うパーソナルアクセストークンを入力し、OK
1. 空の画面が一度表示されるので、OK

# 使い方
1. Mattermostチャンネルのデータソースが追加されているので、閲覧したいチャンネルをソースとした抽出タブを作成してください

# TODO
- チャンネルタイムラインを提供する
- プライベートチャンネル/DM/GMのデータソースを提供する
- アイコンが出ていない
- BOTの投稿をそれとわかるように書く
- システムメッセージが来たらクラッシュするかもしれない

# ライセンス
MIT

