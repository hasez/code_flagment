const https = require('https');

// slack incoming webhook url
const SLACK_PATH = '/services/XXXXX/XXXXX/XXXXX';

var channel = '#md_test_err';
var jobId = 'JOB_ID';
var operatorName = 'OPERATOR_NAME';
var mention = '';
var data = JSON.stringify({ "channel": channel, "text": mention + "\n異常終了した「" + jobId + "」は、" + operatorName + "が対応します。", "icon_emoji": ":rotating_light:" });
console.log("Slack Message:" + data);

//オプション情報設定
var options = {
    hostname: 'hooks.slack.com',
    port: 443,
    path: SLACK_PATH,
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
    }
};

//リクエスト
var req = https.request(options, (res) => {
    if (res.statusCode === 200) {
        console.log("OK:" + res.statusCode);
    } else {
        console.log("Status Error:" + res.statusCode);
    }
});
//エラー時
req.on('error',(e)=>{
    console.error(e);
});

//データ送信
req.write(data);
//終わり
req.end();
