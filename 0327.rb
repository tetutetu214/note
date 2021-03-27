# 【初学者】AWSハンズオン②仮想サーバ（EC2）の作成

## はじめに
お疲れ様です、__[株式会社協栄情報](https://www.cp-info.co.jp/)__システム3部の__[いなむら](https://twitter.com/t9z_a)__です。

今回は前回記事の[【初学者】AWSハンズオン①VPC構築](https://qiita.com/i3no29/items/3c36ee1fe93d5c7f6f0d)の続きから、__仮想サーバ(EC2)__についてのハンズオン記事を書いていきます。

## 概要
仮想サーバ(EC2)__（①AWS操作用の公開鍵・秘密鍵〜②セキュリティグループの作成〜③EC2を起動〜④AMIの作成）__までを構築していく手順をハンズオン形式で公開していきます。



## ①[VPC](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/what-is-amazon-vpc.html)
#### リージョンの選択
__1__：__「東京」リージョンを選択する__
![スクリーンショット 2021-03-04 13.07.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/1704e95e-bffc-f0fb-13cd-0c8b1c7f89ba.png)
#### VPCネットワークの作成
__2__：__VPCを選択__
![スクリーンショット 2021-03-04 13.48.40 2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/572066ca-498f-6392-f38b-7c3ec3a2ab09.png)
__3__：__どんどん選択して作成を進めます(クリックだけ)__
![スクリーンショット 2021-03-04 13.23.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/bffa4891-7356-ecdf-6efb-66f7294d6a56.png)
__4__：__VPCの作成__
　ここでのCIDR（サイダー）は案件などによって変更されてくると思いますが、今は構築出来ればいいので同じCIDRの値でもOKです。
![スクリーンショット 2021-03-04 13.33.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/d0f2ef20-693a-17ae-ec1f-eb1aca8d7847.png)
__5__：__完成詳細画面__
　ただ作る”だけ”なら5分もかからない。だからこそ手を動かして構築してみよう。次は__サブネット__を作ってみるよ。
![スクリーンショット 2021-03-02 10.09.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/2a23d42e-0b62-5ce7-c81c-2555202df8a2.png)

## ②[サブネット](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_Subnets.html)
__1__:__サブネットの選択__
　複数の小さなネットワークに分割して管理していく際の、管理単位のネットワークのことです
![スクリーンショット 2021-03-04 13.48.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/c49039b6-8b2b-770a-c1f2-77b84eebbd51.png)
__2__:__どんどん選択して作成を進めます（このショットいる？）__
![スクリーンショット 2021-03-04 13.59.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/d521b9c0-f299-ff36-e2b9-b4fc86e57964.png)
__3__:__サブネットにおける設定の部分__
　VPC（172.31.0.0/16）の中に、サブネットAZ-a（172.31.1.0/24）とサブネットAZーc（172.31.2.0/24）を構築します。同じ値には出来ないのです。
![スクリーンショット 2021-03-04 18.28.23.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/71fdd62b-ef3f-a890-163a-72488b04b17e.png)
__4__:__完了__
　ただ作る”だけ”なら5分もかからない（2回目）。だからこそ手を動かして構築してみよう。次はルートテーブルです
![スクリーンショット 2021-03-02 10.37.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/0614fa4a-6fd1-cde1-3f6e-c6135890eafe.png)

## ③[ルートテーブル](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_Route_Tables.html)
#### ルートテーブルの作成
__1__:__ルートテーブル選択__
　サブネットの中で稼働する__EC2インスタンス（今回未作成）__のルートを制御するためのものです。インターネットを利用して通信する場合はインターネットゲートウェイ（次の項目）をルーティング先に指定したりします。
![スクリーンショット 2021-03-04 13.48.40 4.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/ba8cca79-569f-1216-5ee8-222b223ddb83.png)
__2__:__ルートテーブルの作成__
![スクリーンショット 2021-03-04 21.08.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/31de6f21-8416-69fa-c755-33f902fcaf33.png)
__3__:__ルートテーブルの完成__
　あっという間！！
![スクリーンショット 2021-03-04 21.12.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/44d42727-b734-14ef-a607-540315bb9592.png)
#### ルートテーブルとサブネットの関連付け
　ですがルートテーブルが出来ただけなので、サブネットと関連づけていきます
__4__:__ルートテーブル選択__
![スクリーンショット 2021-03-04 21.20.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/4df96fe1-5cde-7e0e-9dd8-1e67aa92fb8d.png)
__5__:__関連付け__
![スクリーンショット 2021-03-04 21.33.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/5cde4961-835f-ff2b-2384-e21da28d124a.png)
__6__:__完了__
　こうやってみると関連づけられているのがわかります。最後のインターネットゲートウェイにいきましょう
![スクリーンショット 2021-03-04 21.41.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/d6eb3946-dc87-d732-8a45-4f5a69b4546a.png)

## ④[インターネットゲートウェイ（IGW）](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_Internet_Gateway.html)
#### インターネットゲートウェイの作成
__1__:__インターネットゲートウェイ選択__
　VPC内のEC2インスタンスがインターネットを通じて通信するさに必要になるものです
![スクリーンショット 2021-03-04 22.19.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/8b65ad05-00ce-2de8-e750-db2042de4b6c.png)
__2__:__インターネットゲートウェイ作成__
![スクリーンショット 2021-03-04 22.19.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/e0495b2d-e76a-c114-3878-4f96644668ac.png)
__3__:__インターネットゲートウェイ完成__
![スクリーンショット 2021-03-04 22.22.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/380fb3c0-f995-3599-0f63-7f0f58dd5a3c.png)
#### インターネットゲートウェイとVPCへのアタッチ
__4__:__VPCにアタッチ__
![スクリーンショット 2021-03-04 22.23.42.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/4d9f731c-942d-2f16-b143-c52ed49332cb.png)
__5__:__VPCにアタッチ完成__
先ほどの『detached』状態から、『attached』になっていることがわかります
![スクリーンショット 2021-03-04 22.24.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/4f621894-f8df-5f43-5af6-9e70abb2701d.png)
#### インターネットゲートウェイとルートテーブルの設定
　VPCにアタッチしたことにより、ルートテーブルとインターネットゲートウェイを設定することができるようになりました、さっそく設定しましょう。
__6__:__ルートテーブル選択する__
![スクリーンショット 2021-03-04 22.02.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/8026ea95-e911-595a-fe27-75f0c5876a8c.png)
__7__:__ルートを編集する__
![スクリーンショット 2021-03-04 22.29.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/84755b23-92f9-99f3-3390-bfdebb9c5474.png)
__※2021/03/07　追記__
インターネットゲートウェイ（0.0.0.0/0）へのルーティングを指定しているので、サブネットが__パブリックサブネット__として定義されました（インターネットゲートウェイを指定していないサブネットを__プライベートサブネット__と言います）。

__8__:__インターネットゲートウェイとルートテーブルの設定完了__
お疲れ様でした。これでインターネットからの接続も出来るようになりました。
が、これだと作成したVPCは__外部公開__されている状態です。そのため構成図にもある『__セキュリティグループ__』『__ネットワークACL__』のセキュリティ項目がありますが、こちらは次回に記述します。
![スクリーンショット 2021-03-04 22.31.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/e357f43c-beaf-5618-e921-6798214b5b73.png)

## まとめ
スクショ祭りになってしまいましたが、何かをしたいけど何をしたら__ヨクワカラナイ__なんて方の、少しでも__手を動かすための力__になれたら幸いです。

間違い等ございましたら、お手数ですがご気軽にご教授いただけると幸いです。
ここまで読んでいただき、誠にありがとうございます。

※スクショのタイミングで写っているVPCのIDが異なる部分があり、ご迷惑をおかけします。内容的にはハンズオンに問題ないとしたものを選び利用しています。

## 参考書籍・記事
こちらの記事を参考にさせていただております。

【参考書籍】
[Amazon Web Services パターン別構築・運用ガイド 改](https://www.amazon.co.jp/Amazon-Web-Services-%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5%E6%A7%8B%E7%AF%89%E3%83%BB%E9%81%8B%E7%94%A8%E3%82%AC%E3%82%A4%E3%83%89-%E6%94%B9%E8%A8%82%E7%AC%AC2%E7%89%88-ebook/dp/B07BMQL59H/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=%E3%81%82%E3%81%BE%E3%81%9E%E3%82%93+Service+%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5&qid=1614865933&sr=8-1)
[Amazon Web Services 業務システム設計・移行ガイド](https://www.amazon.co.jp/Amazon-Web-Services-%E6%A5%AD%E5%8B%99%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A8%AD%E8%A8%88%E3%83%BB%E7%A7%BB%E8%A1%8C%E3%82%AC%E3%82%A4%E3%83%89-%E4%B8%80%E7%95%AA%E5%A4%A7%E5%88%87%E3%81%AA%E7%9F%A5%E8%AD%98%E3%81%A8%E6%8A%80%E8%A1%93%E3%81%8C%E8%BA%AB%E3%81%AB%E3%81%A4%E3%81%8F-%E4%BD%90%E3%80%85%E6%9C%A8-ebook/dp/B0793JRHYC/ref=pd_vtp_2?pd_rd_w=WcDJz&pf_rd_p=726d0243-39d6-4e23-8ceb-5451be2e842b&pf_rd_r=ZGARH1YNC5B9A7V7SS22&pd_rd_r=f0cfe7b2-9a99-4276-9151-033cadccccec&pd_rd_wg=C7n6P&pd_rd_i=B0793JRHYC&psc=1)
【サイト】
[0から始めるAWS入門①：VPC編](https://qiita.com/hiroshik1985/items/9de2dd02c9c2f6911f3b)
[【初心者向け】初めて VPC 環境作成してみた](https://dev.classmethod.jp/articles/myfirstnvpcsetup/)
