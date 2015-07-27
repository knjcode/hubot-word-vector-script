# Description
#   word-vector-web-api wrapper for hubot
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_WORD_VECTOR_URL   - word-vector-web-apiのURL
#   HUBOT_WORD_VECTOR_COUNT - 検索結果の表示件数を制限する(デフォルトは5件)
#
# Commands:
#   hubot distance <string> - ベクトルが近い語を出力
#   hubot analogy <str1> <str2> <str3> - "str1 - str2 + str3" にベクトルが近い語を出力
#
# Notes:
#   word-vector-web-api は @overlast さんによる
#   Word2Vec を Web API として利用できるアプリケーションです
#   <https://github.com/overlast/word-vector-web-api>
#
# Author:
#   knjcode <knjcode@gmail.com>

baseUrl = process.env.HUBOT_WORD_VECTOR_URL
if !baseUrl
  console.error("ERROR: You should set HUBOT_WORD_VECTOR_URL env variables.")

dispCount = process.env.HUBOT_WORD_VECTOR_COUNT ? 5

module.exports = (robot) ->
  robot.respond /distance (.*)/i, (msg) ->
    if !baseUrl
      robot.logger.error("You should set HUBOT_WORD_VECTOR_URL env variables.")
      return
    query = msg.match[1]
    robot.http(baseUrl+"/distance?a1=#{query}")
      .get() (err, res, body) ->
        if err
          robot.logger.error("#{err}")
          return
        try
          result = JSON.parse(body)
          items = result.items
          res = []
          count = if items.length < dispCount then items.length else dispCount
          for item in items[0...count]
            res.push(item.term + " (" + item.score + ")")
          if res.length > 0
            msg.send res.join('\n')
          else
            msg.send("見つかりませんでした")
        catch e
          robot.logger.error("#{e}")

  robot.respond /analogy (.*)/i, (msg) ->
    if !baseUrl
      robot.logger.error("You should set HUBOT_WORD_VECTOR_URL env variables.")
      return
    words = msg.match[1].replace(/:| |　/g,'<>').split('<>')
    if words.length isnt 3
      msg.send("クエリを3つ入力してください")
      return

    robot.http(baseUrl+"/analogy?a1=#{words[0]}&a2=#{words[1]}&a3=#{words[2]}")
      .get() (err, res, body) ->
        if err
          robot.logger.error("#{err}")
          return
        try
          result = JSON.parse(body)
          items = result.items
          res = []
          count = if items.length < dispCount then items.length else dispCount
          for item in items[0...count]
            res.push(item.term + " (" + item.score + ")")
          if res.length > 0
            msg.send res.join('\n')
          else
            msg.send("見つかりませんでした")
        catch e
          robot.logger.error("#{e}")
