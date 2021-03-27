# 【初学者】AWSハンズオン②仮想サーバ（EC2）の作成

## はじめに
今回は前回記事の[【初学者】AWSハンズオン①VPC構築](https://qiita.com/i3no29/items/3c36ee1fe93d5c7f6f0d)の続きから、__仮想サーバ([EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc))__についてのハンズオン記事を書いていきます。

##用語
・[EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc)（＝Amazon　Elastic　Compute Cloudの略称　Cが2つ続く）AWS上に仮想サーバを構築することが出来る技術
・EC2によって起動された仮想サーバを『__インスタンス__』
・インスタンスの起動するための情報が含まれているもの『__AMI__』
・インスタンスの仮想ファイヤーウォールを『__セキュリティグループ__』
・インスタンスにログインするために『__キーペア（公開鍵・秘密鍵）__』が必要となる

##手順概要
①AMIの選択〜②インスタンスタイプの選択〜③詳細設定〜④ストレージの追加〜⑤タグの追加〜⑥セキュリティグループの作成〜⑦インスタンスの起動）__までを構築していく手順をハンズオン形式で公開していきます。

## EC2インスタンスを作成
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
![スクリーンショット 2021-03-27 14.13.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/300f8b83-ec67-833a-63de-1a64da484f41.png)
今回の場合では、AWSにアクセスしているIPアドレスに限定したセキュリティグループを設定しています

###インスタンスの起動
右下に青色の【起動】があるので選択します
![スクリーンショット 2021-03-27 14.23.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/def20140-a2bf-8b77-324e-26b29b774e06.png)

###キーペアの作成について
EC2は__公開鍵暗号方式__でログイン情報を暗号化しています。そのためログインには、キーペア（公開鍵・秘密鍵）が必要となります（ないと作り直し）。ちなみにキーペアのファイルのダウンロードタイミングはここしかないため、同じインスタンスで二度目のダウンロードはありません。
![スクリーンショット 2021-03-27 14.35.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/a48ffe04-6cb9-3f45-8f5b-7c500a2c9192.png)

###作成ステータス画面
画面が遷移しそうですが変化がないので、ダッシュボードに移動して確認してみましょう
![スクリーンショット 2021-03-27 14.35.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/96d41cf2-d2c2-28e0-08c3-5a94c62d16da.png)

###EC2ダッシュボードで確認
【インスタンスEC2の状態】を確認すると実行中となっているので、無事に起動していることがわかります
![スクリーンショット 2021-03-27 14.58.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/10587966-45a0-a0b8-ed31-b94cfe6e7f89.png)

## まとめ
前回に引き続き__ヨクワカラナイ__なんて方の、少しでも__手を動かすための力__になれたら幸いです。

間違い等ございましたら、お手数ですがご気軽にご教授いただけると幸いです。
ここまで読んでいただき、誠にありがとうございます。

次回は、今回作成したEC2にアクセスしていきたいと思います

## 参考書籍・記事
こちらの記事を参考にさせていただております。

【参考書籍】
[Amazon Web Services パターン別構築・運用ガイド 改](https://www.amazon.co.jp/Amazon-Web-Services-%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5%E6%A7%8B%E7%AF%89%E3%83%BB%E9%81%8B%E7%94%A8%E3%82%AC%E3%82%A4%E3%83%89-%E6%94%B9%E8%A8%82%E7%AC%AC2%E7%89%88-ebook/dp/B07BMQL59H/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=%E3%81%82%E3%81%BE%E3%81%9E%E3%82%93+Service+%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5&qid=1614865933&sr=8-1)
[Amazon Web Services 業務システム設計・移行ガイド](https://www.amazon.co.jp/Amazon-Web-Services-%E6%A5%AD%E5%8B%99%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A8%AD%E8%A8%88%E3%83%BB%E7%A7%BB%E8%A1%8C%E3%82%AC%E3%82%A4%E3%83%89-%E4%B8%80%E7%95%AA%E5%A4%A7%E5%88%87%E3%81%AA%E7%9F%A5%E8%AD%98%E3%81%A8%E6%8A%80%E8%A1%93%E3%81%8C%E8%BA%AB%E3%81%AB%E3%81%A4%E3%81%8F-%E4%BD%90%E3%80%85%E6%9C%A8-ebook/dp/B0793JRHYC/ref=pd_vtp_2?pd_rd_w=WcDJz&pf_rd_p=726d0243-39d6-4e23-8ceb-5451be2e842b&pf_rd_r=ZGARH1YNC5B9A7V7SS22&pd_rd_r=f0cfe7b2-9a99-4276-9151-033cadccccec&pd_rd_wg=C7n6P&pd_rd_i=B0793JRHYC&psc=1)
【サイト】
[0から始めるAWS入門①：EC2編](https://qiita.com/hiroshik1985/items/f078a6a017d092a541cf)
