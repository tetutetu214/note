# 【初学者】AWSハンズオン②仮想サーバ（EC2）の作成

## はじめに
今回は前回記事の[【初学者】AWSハンズオン①VPC構築](https://qiita.com/i3no29/items/3c36ee1fe93d5c7f6f0d)の続きから、__仮想サーバ([EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc))__についてのハンズオン記事を書いていきます。

##概要
[EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc)（＝Amazon　Elastic　Compute Cloudの略称）
AWS上に仮想サーバを構築することが出来る技術

EC2によって起動された仮想サーバを『__インスタンス__』
インスタンスにログインするために『__公開鍵・秘密鍵__』が必要となる
インスタンスの仮想ファイヤーウォールを『__セキュリティグループ__』
インスタンスの起動するための情報が含まれているもの『__AMI__』

##手順概要
仮想サーバ([EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc))__（①EC2インスタンスを作成〜②セキュリティグループの作成〜③EC2を起動〜④AMIの作成）__までを構築していく手順をハンズオン形式で公開していきます。

## ①EC2インスタンスを作成
###AWSマネジメントコンソールから【EC2】を選択する
![スクリーンショット 2021-03-27 9.59.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/a868e70d-7f56-b3f9-c636-1e5200245eec.png)
左にある【▼インスタンス】の下の【インスタンス】を選択する
![スクリーンショット 2021-03-27 10.02.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/a29a73bb-a01e-1269-cf54-dca6cfb177e1.png)
画面上右上にあるオレンジ色の【インスタンスを起動】を選択する
![スクリーンショット 2021-03-27 10.03.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/c6ecf960-041c-f85b-67fb-571d558a232e.png)
###__AMI__の選択
これから作成するインスタンスのソフトウェア構成（OS、アプリケーションサーバ、アプリケーション）を含むテンプレート情報です
「無料利用枠の対象」というラベルのものは無料のAMIです
![スクリーンショット 2021-03-27 10.04.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/3216f0bd-6704-1fb8-6cc8-94b3212c3b44.png)
###__インスタンスタイプ__の選択
利用したいアプリケーションの都合により変わりますが、今回は「[無料利用枠の対象](https://aws.amazon.com/jp/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc)」のものを選択していきます。
![スクリーンショット 2021-03-02 10.58.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/8a0cb363-23b6-b4ad-0c3e-5c20b041c046.png)
###__詳細設定__の選択

|主な設定項目  |説明  |
|---|---|
|インスタンス数  |起動するインスタンスの数の設定 |
|購入オプション  |[スポットインスタンス](https://aws.amazon.com/jp/ec2/spot/?cards.sort-by=item.additionalFields.startDateTime&cards.sort-order=asc)として購入するかどうか？  |
|ネットワーク |EC2を所属するVPC |
| サブネット  |EC2が所属するサブネット |
| 自動割り当てパブリック IP |自動的にパブリックIPを付与するかの設定 |
|IAM ロール  |EC2にIAM権限を選択させるか|
|シャットダウン動作 |EC2シャットダウンした際の動作を指定する |
|終了保護の有効化  |誤って消去を防止したり、インスタンス削除を禁止する |
|モニタリング  |CloudWatchの詳細モニタリングの有効か・無効化 |
![スクリーンショット 2021-03-27 10.52.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/bc7a189c-13b9-10d9-7566-74f82c0a0260.png)
▶︎ネットワークインターフェイス
__サブネット__を選択するとEC2の__プライベートIP__を指定することが出来る
指定しない場合は自動的にIPアドレスが割り当てられる（今回初期設定のままです）
▶︎高度な詳細
シェルスクリプトもしくはcloudinitディレクティブを記述して、インスタンス起動時の動作（パッケージのインストール、ユーザーなどの作成など）を詳細に設定することが出来るようになる（今回未設定です）

###__ストレージの追加__
EC2に関連づけるストレージを選択（今回は初期設定のままです）
そのため初期値のルートデバイス サイズ8(GB) ボリュームタイプ　汎用SSD（gp2）　暗号化なしの状態です
![スクリーンショット 2021-03-27 11.21.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/d62c9ed0-34c9-ec28-36b9-041e4df57d25.png)

###__タグの追加__
インスタンスの名称（具体的な内容など）入力しておくことで、このEC2がなんのために利用されているのかわかるようにしておきます（任意によるものでタグがなくても機能的な問題はありません）
![スクリーンショット 2021-03-27 11.43.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/04f76678-f2cd-a9af-2f2d-f6c59f5bfe2d.png)

###__セキュリティグループの設定__
__セキュリティグループ__（＝AWSにおけるファイヤーウォールのこと）
このセキュリティグループはホワイトリスト方式（記述したもののみ許可する）なので、指定しなければ全て拒否することになります