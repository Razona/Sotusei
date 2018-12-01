

        var syukusyaku = 0.8;
        var map_x = 600*syukusyaku;
        var map_y = 900*syukusyaku;

        //体験者の初期位置
        var x=30;
        var y=900*syukusyaku -30 ;



        var mouseX_kako=0;
        var mouseY_kako=0;
        var idou_kyoka = false;
        var mousePressed_hantei = false;


        var switch_mouse_over = false;
        var map_ryouiki = false;

        //sim_mode:0はマウスで動かすモード,sim_mode:1はoscで受けた値を使って描画するモード
        var sim_mode = 1;


        function setup(){
            //640×480のCanvasを生成
            createCanvas(700,720);
            background(0);
        }

        function draw(){
            //xが320,yが240,直径が100の円を描画
            background(0);

            map_ryouiki_hantei();

            if (map_ryouiki == true && sim_mode == 0){
              mouse_iti_jouhou();
              idou_kyoka_hantei();
            }

            map_byouga();
            povar_byouga();


            jouhou_byouga();

            mode_switch();

        }

        //展示部屋の図を描画
        function map_byouga(){
          fill(150);
          rect(0,0,map_x,map_y);
        }

        //現在地を示す点を描画
        function povar_byouga(){
          fill(255);
          ellipse(x,y,10,10);
        }

        //各種情報の描画
        function jouhou_byouga(){
          fill(0,255,0);
          var tate_soroe = 680;


          text("管理用ツール v0.01",tate_soroe*syukusyaku,50*syukusyaku);


        if (sim_mode ==0 ){
          //シミュレーターモード用の情報
          text("現在地",tate_soroe*syukusyaku,170*syukusyaku);
          text("x:"+x,tate_soroe*syukusyaku,200*syukusyaku);
          text("y:"+y,tate_soroe*syukusyaku,230*syukusyaku);

          text("その他情報", tate_soroe*syukusyaku ,270*syukusyaku);
          text("マウスX差分:"+mouseX_kako, tate_soroe*syukusyaku ,300*syukusyaku);
          text("idou_kyoka:"+idou_kyoka, tate_soroe*syukusyaku ,330*syukusyaku);
        }else if (sim_mode == 1){
          text("現在地",tate_soroe*syukusyaku,170*syukusyaku);
          text("x:"+x,tate_soroe*syukusyaku,200*syukusyaku);
          text("y:"+y,tate_soroe*syukusyaku,230*syukusyaku);

          text("ネットワーク接続", tate_soroe*syukusyaku ,270*syukusyaku);
          text("いつか実装", tate_soroe*syukusyaku ,290*syukusyaku);
        }

        }

        //現在地の情報を更新
        function mouse_iti_jouhou (){
          if (mouseButton == LEFT){
            //_kakoの値のリフレッシュを行う
            if (idou_kyoka == false){
              mouseX_kako = mouseX;
              mouseY_kako = mouseY;
              idou_kyoka = true;
            }

            //sabun_x でmouseXとmousex_kakoを比較
            //この関数の最後にmouseX_kakoに代入
            var  sabun_x = mouseX - mouseX_kako;
            var sabun_y = mouseY - mouseY_kako;
            console.log("x:"+sabun_x);
            console.log("過去x:"+mouseX_kako);
            console.log("結果x"+x);
            x = x + sabun_x;
            y = y + sabun_y;

            mouseX_kako = mouseX;
            mouseY_kako = mouseY;
          }

          if (mouseButton == RIGHT){
            //右クリックの場合、座標がクリックした場所にワープ
            x = mouseX;
            y = mouseY;
          }
        }


        // iti_jouhouに関連して、移動許可を出す関数
        function idou_kyoka_hantei(){
          if (mousePressed_hantei == false){
            idou_kyoka = false;
            // console.log("移動許可:"+false);
          }
        }

        function mousePressed(){
          mousePressed_hantei = true;
        }

        function mouseReleased(){
          mousePressed_hantei = false;
          idou_kyoka = false;
          // console.log("移動許可:"+false);
        }


        //マウスがマップの上にあるかの判定
        function map_ryouiki_hantei(){
          if (0<mouseX&&mouseX<map_x&&0<mouseY&&mouseY<map_y){
            map_ryouiki = true;
          }else {
            map_ryouiki = false;
          }
        }


        //モード切り替えのスイッチに関する関数
        function mode_switch(){

          //マウスオーバーしてるかの判定
          //してたら、switch_mouse_overがtrueになる
          if (690*syukusyaku<mouseX&&mouseX<810*syukusyaku&&750*syukusyaku<mouseY&&mouseY<780*syukusyaku){
            switch_mouse_over = true;
          } else{
            switch_mouse_over = false;
          }

          //ボタンの描画について。
          stroke(255);
          if (switch_mouse_over == false){
            noFill();
          }else {
            fill(255);
          }
          rect(690*syukusyaku,750*syukusyaku,120*syukusyaku,30*syukusyaku);


          //中のテキストについて
          if (switch_mouse_over == false){
            fill(255);
          }else if (switch_mouse_over == true){
            fill(0);
          }
          if (sim_mode == 0){
              text("シミュレーター",695*syukusyaku,770*syukusyaku);
          }else if(sim_mode == 1){

            text("監視モード",710*syukusyaku,770*syukusyaku);
          }
        }

        //クリックされたら呼び出される
        function mouseClicked(){
          //ボタン機能の実装
          if (switch_mouse_over==true&&sim_mode==0){
            sim_mode=1;
          }else if (switch_mouse_over==true&&sim_mode==1){
            sim_mode = 0;
          }
        }
