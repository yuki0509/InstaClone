//= require jquery/dist/jquery.js
//= require popper.js/dist/umd/popper.js
//= require rails-ujs
//= bootstrap-material-design/dist/js/bootstrap-material-design.js 

function previewFileWithId(selector) {
  // event.targetはイベント元のオブジェクトを読み込む。ここではfile_filesヘルパーで生成されたinputタグ。
  const target = event.target;
  // ファイルを選択。一つしかないので、files[0]でよい。
  const file = target.files[0];
  const reader = new FileReader();
  // ファイルの読み込みが終了した時に発火するイベント。
  reader.onloadend = function () {
    // reader.resultでファイルデータを表す文字列を出力する。
    selector.src = reader.result;
  }
  if (file) {
    // readDataURLメソッドは、指定したファイルを読み込身を完了させるメソッド。読み込みが完了したら、loadendイベントが生ずる。
    reader.readAsDataURL(file);
  } else {
    selector.src = "";
  }
}