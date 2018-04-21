# Web App for Containerを使ってRailsアプリを動かす

## 参考

- https://www.slideshare.net/yokawasa/web-app-for-containers-mysqlrails-80754390

このスライドを参考に、MySQLの部分をPostgreSQLで実装してみる。Azure CLIで操作しても良かったんだけど、なんとなくポータルで操作。

## ポータルでの操作

### PostgreSQLの作成

- 作成自体は簡単にできる。スライドにあるファイアウォールの設定で、今回は「以降のアプリテスト簡略化のため」とあるが、実際にはどうすればいいんだろう。
  - Web Appの送信元はプロパティから見ることができるのでそこで制限する。

### Web App for Containerの作成

- PostgreSQLへの接続用環境変数設定が必要
  - アプリケーション設定からPostgreSQLへの接続用環境変数を設定する
  - 環境変数を設定したあとにアプリの再起動すると有効になる感じ
- dockerコンテナーの設定は、タグも含めて全部設定する