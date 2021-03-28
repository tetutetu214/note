# 【初学者】AWSハンズオン③仮想サーバ（EC2）へログイン

## はじめに
[【初学者】AWSハンズオン①VPC構築](https://qiita.com/i3no29/items/3c36ee1fe93d5c7f6f0d)

今回は前回記事の[【初学者】AWSハンズオン②仮想サーバ（EC2）の作成](https://qiita.com/i3no29/items/0afc2e06a5c3e7190361)の続きから、__仮想サーバ([EC2](https://aws.amazon.com/jp/ec2/?ec2-whats-new.sort-by=item.additionalFields.postDateTime&ec2-whats-new.sort-order=desc))__へ__ログイン__についてのハンズオン記事を書いていきます。

##用語
・インスタンスにログインするために『__キーペア（公開鍵・秘密鍵）__』が必要となる
・__SSH__とは「Secure Shell」の略で、ネットワークに接続された機器を__遠隔操作__して管理するための手段

【参考サイト】
[インフラエンジニアじゃなくても押さえておきたいSSHの基礎知識](https://qiita.com/tag1216/items/5d06bad7468f731f590e)

## 手順概要
__①事前準備1（VPC・サブネット）〜②事前準備2（AMI・EC2停止起動）〜③EC2（インスタンス）へSSH接続してログイン__までを構築していく手順をハンズオン形式で公開していきます。

## EC2へログイン
### ①事前準備1(VPC・サブネットの変更）
PCのターミナルからインスタンスにアクセスしようとしたところ、VPC・サブネットにパブリックIPv4（赤枠の部分）を設定していなかったためアクセスが出来ませんでした。
そのためインスタンスをSSH接続できるように、パブリックIPを取得していきます。
![スクリーンショット 2021-03-28 9.10.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/b79f0f44-c68e-0288-cd20-4f8a0cab14ec.png)
#### VPCを確認してみる
【DNSホスト名　無効（写真撮り忘れ）】になっているのを確認できたので、ホスト名を編集していきます
![スクリーンショット 2021-03-28 9.24.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/c3ebd3a1-1d30-a1a1-bf03-8742bebd9a67.png)
![スクリーンショット 2021-03-28 9.24.17.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/885e9c0f-6cc4-3c25-7c99-a513f5b6f58f.png)
![スクリーンショット 2021-03-28 9.24.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/a6748c81-219f-8929-cac0-a3c0ac0d0a10.png)
#### サブネットを確認してみる
詳細【パブリックIPv4　アドレスを自動割り当て　いいえ】と確認できたので、自動割り当てされるように設定していきます
![スクリーンショット 2021-03-28 9.26.02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/c5307748-13e2-8b3f-2778-396fffeb8ba7.png)
![スクリーンショット 2021-03-28 9.26.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/68cd09ff-caa7-68ab-1188-0ea6ca93e88f.png)
![スクリーンショット 2021-03-28 9.26.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/b433b08d-ca79-8636-bb3a-e334cccde8e7.png)
無事に【パブリックIPv4　アドレスを自動割り当て　はい】になったことが確認できました
### ②事前準備2（AMI・EC2停止起動）
再度インスタンスを立ち上げなければ反映されないので、インスタンスを終了させるまえにAMIを取得しておきます（現段階でのAMIの内容情報は少ないので終了でもいいかとは思ったのですが、学習のためAMIを作成）
#### AMIを作成していく
![スクリーンショット 2021-03-28 9.32.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/2de6d497-e154-26ec-b0b1-3b6a2195e269.png)
![スクリーンショット 2021-03-28 9.38.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/b859bd7c-cfb0-2f35-afb5-c77ae6fa4d47.png)
![スクリーンショット 2021-03-28 9.41.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/bbf713fc-9292-cada-3c55-d09494beb35c.png)
![スクリーンショット 2021-03-28 9.41.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/991a18b8-6d93-bc66-68ad-c86221dcbe2d.png)
![スクリーンショット 2021-03-28 9.43.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/ab77b286-ba0e-ad20-4543-aa320181d836.png)
#### 前回作成したEC2を削除する
![スクリーンショット 2021-03-28 9.42.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/e1412afd-2c6d-4fd0-cbcc-3c1ebaa84a11.png)
#### AMIからEC2（インスタンス）を作成していく
前回のEC2と同じ内容で作成していきます（AMIの恩恵は今回はあまりないです）
![スクリーンショット 2021-03-28 9.43.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/630469a7-83d4-5a2f-0c98-28445a6e1b44.png)
#### EC2停止起動
起動して詳細を確認すると、VPC・サブネットにパブリックIPv4（赤枠の部分）が設定されて、インスタンスにも反映されていることがわかりました
![スクリーンショット 2021-03-28 9.49.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/42ca2772-834c-e9a6-8096-69fa148b8ac0.png)

### ③EC2（インスタンス）へSSH接続してログイン
早速ターミナルからインスタンスへログインをおこなっていきます
#### ターミナルからのログイン
![スクリーンショット 2021-03-28 9.09.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/b23e5e6a-bd90-d187-c41f-1b1c7a8c8ea2.png)

```
% mkdir ~/ .ssh
【.ssh】というディレクトリ（フォルダ）を作成する
既に私の場合はディレクトリがあるので、Filse existsとエラーが表示されています
```
```
% mv Downloads/ダウンロードした鍵の名前.pem .ssh/
mvコマンドでダウンロードしたファイルを、【.ssh】というディレクトリ（フォルダ）へ移動
```
```
% cd .ssh/
cdコマンドで【.ssh】ディレクトリに移動（四角で囲っていますが、移動したのがわかるかと思います）
% ls
lsコマンドで【.ssh】ディレクトリの内部を確認すると、ダウンロードした鍵の名前.pemが移動していることがわかります
```
```
% chmod 600 ダウンロードした鍵の名前.pem
chmodコマンドで【ダウンロードした鍵の名前.pem】の権限を「0600」にします
```
【参考サイト】
[chmod コマンド](https://qiita.com/ntkgcj/items/6450e25c5564ccaa1b95)
<br />
※ssh接続を実行した際、以下のようなメッセージが表示されることがありますが「__yes__」と入力して実行してください
![スクリーンショット 2021-03-28 10.29.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/126aaba5-c200-7c01-a10b-8a25eab36ba6.png)
#### インスタンスへアクセスする
```
ssh -i ダウンロードした鍵の名前.pem ec2-user@作成したEC2インスタンスのパブリックIPv4 DNS
```
上記のコマンドをターミナルに打ち込み下記の画像が表示されたらログインが成功です
![スクリーンショット 2021-03-28 10.02.23.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/694365/e7bbf7fb-2f70-bf10-4cfb-6cc31ebd6e9d.png)


## まとめ
前回、前々回に引き続き__ヨクワカラナイ__なんて方の、少しでも__手を動かすための力__になれたら幸いです。

間違い等ございましたら、お手数ですがご気軽にご教授いただけると幸いです。
ここまで読んでいただき、誠にありがとうございます。

【AWS　ハンズオン】
[【初学者】AWSハンズオン①VPC構築](https://qiita.com/i3no29/items/3c36ee1fe93d5c7f6f0d)
[【初学者】AWSハンズオン②仮想サーバ（EC2）の作成](https://qiita.com/i3no29/items/0afc2e06a5c3e7190361)


## 参考書籍・記事
こちらの記事を参考にさせていただております。

【参考書籍】
[Amazon Web Services パターン別構築・運用ガイド 改](https://www.amazon.co.jp/Amazon-Web-Services-%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5%E6%A7%8B%E7%AF%89%E3%83%BB%E9%81%8B%E7%94%A8%E3%82%AC%E3%82%A4%E3%83%89-%E6%94%B9%E8%A8%82%E7%AC%AC2%E7%89%88-ebook/dp/B07BMQL59H/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=%E3%81%82%E3%81%BE%E3%81%9E%E3%82%93+Service+%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E5%88%A5&qid=1614865933&sr=8-1)
[Amazon Web Services 業務システム設計・移行ガイド](https://www.amazon.co.jp/Amazon-Web-Services-%E6%A5%AD%E5%8B%99%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A8%AD%E8%A8%88%E3%83%BB%E7%A7%BB%E8%A1%8C%E3%82%AC%E3%82%A4%E3%83%89-%E4%B8%80%E7%95%AA%E5%A4%A7%E5%88%87%E3%81%AA%E7%9F%A5%E8%AD%98%E3%81%A8%E6%8A%80%E8%A1%93%E3%81%8C%E8%BA%AB%E3%81%AB%E3%81%A4%E3%81%8F-%E4%BD%90%E3%80%85%E6%9C%A8-ebook/dp/B0793JRHYC/ref=pd_vtp_2?pd_rd_w=WcDJz&pf_rd_p=726d0243-39d6-4e23-8ceb-5451be2e842b&pf_rd_r=ZGARH1YNC5B9A7V7SS22&pd_rd_r=f0cfe7b2-9a99-4276-9151-033cadccccec&pd_rd_wg=C7n6P&pd_rd_i=B0793JRHYC&psc=1)
【サイト】
[0から始めるAWS入門①：EC2編](https://qiita.com/hiroshik1985/items/f078a6a017d092a541cf)
[インフラエンジニアじゃなくても押さえておきたいSSHの基礎知識](https://qiita.com/tag1216/items/5d06bad7468f731f590e)
[chmod コマンド](https://qiita.com/ntkgcj/items/6450e25c5564ccaa1b95)
