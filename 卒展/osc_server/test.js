//JSON文字列
var data = { x: '0.03947',
    y: '0.00284',
    z: '0.24487',
    gx: '0.24241',
    gy: '-0.06509',
    gz: '-9.55945',
    a: '-0.01869',
    b: '0.12906',
    g: '-0.26111',
    hosuu: 0,
    version: 'mozilla/5.0 (iphone; cpu iphone os 10_3_3 like mac os x) applewebkit/603.1.30 (khtml, like gecko) crios/68.0.3440.83 mobile/14g60 safari/602.1' };

//JavaScriptオブジェクトへ変換
// var obj = JSON.parse(jsonStr);
// console.log(JSON.stringify(obj));

console.log(data['x']);
