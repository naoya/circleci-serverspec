circleci-serverspec
===================

これは何
--------

CI as a Service を使ってインフラのCIする例。

- CircleCI で vagrant + serverspec を使ったインフラの Continuous Integration を流す
- CircleCI の中では virtualbox は動かせないので、vagrant-aws を使い EC2 に一時的にインスタンスを作ってテストを流す
- CI の開始時に VM を立ち上げ、終わったら VM を破棄。
- サーバーのプロビジョニングには Chef + knife-solo を利用

テストの流れは `circle.yml` を見るのがはやい

CIしてるスクリーンショット
--------------------------

<a href="https://dl.dropboxusercontent.com/u/2586384/image/20131214_074223.png"><img src="https://dl.dropboxusercontent.com/u/2586384/image/20131214_074223.png" width="480" /></a>

細かなところ
------------

- CircleCI には vagrant はパッケージから入れられないため、git から入れる
- Vagrantfile が参照する AWS の API キーは、CircleCI の環境変数設定に入れてそれ経由で受け取る
- EC2 のログイン用 ssh 鍵は CircleCI に登録した鍵を使う ... そのパスを環境変数に入れて受け渡し
- serverspec に EC2 の ssh 情報を渡すのには vagrant ssh-config を一度ファイル出力してやっている
    - serverspec 内から直接 vagrant ssh-config 実行でもいいかも。一度失敗したのでまだそうしてない
    - `VAGRANT_INSTALLER_ENV` を true にしないと vagrant の warning が ssh_config の出力に入ってしまうので true に
- `rake spec` を普通に実行した場合はローカルの vagrant でテスト、`REMOTE_TEST=1` をつけるとリモートの vagrant でテストするよう `spec_helper.rb` を調整

実際に動かす場合
----------------

### 事前準備

- AMI を用意
    - 本レポジトリではオリジナルの Amazon Linux だと、vagrant や serverspec が要求する tty なしの sudo が禁止になってるので、その設定を変更にした AMI を使っている

### CircleCI の設定

- EC2 で CI 用の Key Pair を作って Edit settings > SSH keys からアップロード
- Edit settings > Environment variables に以下を登録
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
    - `AWS_SSH_KEY_PATH` : 先にアップロードしたsshのパス。コンテナに ssh ログインして `~/.ssh` を覗くと分かる

