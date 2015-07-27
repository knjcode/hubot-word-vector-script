# hubot-word-vector-script

[overlast](https://github.com/overlast) さんによる Word2Vec の WebAPI である
[word-vector-web-api](https://github.com/overlast/word-vector-web-api/blob/master/README.ja.md) を
hubot から利用する

## インストール

npmでインストール

```
$ npm install --save knjcode/hubot-word-vector-script
```

or

```
$ npm install --save https://github.com/knjcode/hubot-word-vector-script/archive/master.tar.gz
```

`external-scripts.json`に`hubot-word-vector-script`を追加

```
$ cat external-scripts.json
["hubot-word-vector-script"]
```

## word-vector-web-api の準備

[README](https://github.com/overlast/word-vector-web-api/blob/master/README.ja.md)
を参考に word-vector-web-api を導入します。

APIとしては以下のように利用できます。

```
$ curl "http://localhost:22670/distance?a1=寿司"
{"method": "distance", "format": "json", "items": [
{"term": "握り寿司", "score": 0.7822030782699585},　{"term": "江戸前寿司", "score": 0.77414518594741821}, 
{"term": "押し寿司", "score": 0.77050793170928955}, {"term": "うどん", "score": 0.76514482498168945}, 
{"term": "天ぷら", "score": 0.7647247314453125}, {"term": "おでん", "score": 0.75914901494979858}, 
{"term": "ラーメン", "score": 0.7530028223991394}, {"term": "おにぎり", "score": 0.75069379806518555}, 
{"term": "巻き寿司", "score": 0.75040823221206665}, {"term": "しゃぶしゃぶ", "score": 0.74389779567718506}, 
{"term": "日本料理", "score": 0.74245506525039673}, {"term": "酢飯", "score": 0.74163687229156494}, 
{"term": "ちらし寿司", "score": 0.74119293689727783}, {"term": "中華料理", "score": 0.7407233715057373}, 
{"term": "麺類", "score": 0.73966968059539795}, {"term": "軍艦巻き", "score": 0.73962771892547607}, 
{"term": "寿司屋", "score": 0.73787486553192139}, {"term": "料理", "score": 0.73675769567489624}, 
{"term": "丼物", "score": 0.72888869047164917}, {"term": "蕎麦", "score": 0.72767460346221924}, 
{"term": "刺身", "score": 0.7261509895324707}, {"term": "鍋料理", "score": 0.72471451759338379}, 
{"term": "料理店", "score": 0.72462576627731323}, {"term": "焼肉", "score": 0.72449952363967896}, 
{"term": "和食", "score": 0.72130364179611206}, {"term": "チャーハン", "score": 0.72093665599822998}, 
{"term": "すき焼き", "score": 0.7177349328994751}, {"term": "トンカツ", "score": 0.71647495031356812}, 
{"term": "早ずし", "score": 0.71499419212341309}, {"term": "ご飯", "score": 0.71361935138702393}, 
{"term": "にぎり寿司", "score": 0.71285635232925415}, {"term": "照り焼き", "score": 0.7118719220161438}, 
{"term": "鍋物", "score": 0.71128165721893311}, {"term": "たこ焼き", "score": 0.70872247219085693}, 
{"term": "丼", "score": 0.70830398797988892}, {"term": "エビフライ", "score": 0.70730042457580566}, 
{"term": "佃煮", "score": 0.70715677738189697}, {"term": "とんかつ", "score": 0.70401555299758911}, 
{"term": "茶漬け", "score": 0.70242542028427124}, {"term": "蒲焼", "score": 0.70182281732559204}
], "query": "寿司", "total_count": 40, "status": "OK", "sort": "cosine similarity"}
```

## 環境変数設定

下記の環境変数を設定して hubot を起動

- **HUBOT_WORD_VECTOR_URL**  
word-vector-web-api の URLを指定（必須）  
ローカルにインストールした場合:  
`export HUBOT_WORD_VECTOR_URL="http://localhost:22670"`

- **HUBOT_WORD_VECTOR_COUNT**  
検索結果の表示件数を制限する（デフォルトは5件）  
30件の場合:  
`export HUBOT_WORD_VECTOR_COUNT=30`

## 使い方

### distance コマンド

`hubot distance <string>`

`<string>`にベクトルが近い語を出力

```
user1>> hubot distance 寿司
hubot>> 握り寿司 (0.7822030782699585)
江戸前寿司 (0.7741451859474182)
押し寿司 (0.7705079317092896)
うどん (0.7651448249816895)
天ぷら (0.7647247314453125)
```

### analogy コマンド

`hubot analogy <str1> <str2> <str3>`

`<str1> - <str2> + <str3>` にベクトルが近い語を出力

```
user1>> hubot analogy SONY PlayStation Nintendo
hubot>> Wii (0.7002160549163818)
ゲームボーイアドバンス (0.694932758808136)
ニンテンドーDS (0.6919329166412354)
ニンテンドー3DS (0.6773288249969482)
NINTENDO64 (0.6766645312309265) 
```
