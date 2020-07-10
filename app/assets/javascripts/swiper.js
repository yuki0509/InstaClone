//DOMを読み込んだ後に、イベントを発生させるようにする
$(function() {
  new Swiper('.swiper-container', {

    //スクロールバー
    scrollbar: {
      el: '.swiper-scrollbar',
      hide: true,
    },
})});
