//DOMを読み込んだ後に、イベントを発生させるようにする
$(function() {
  new Swiper('.swiper-container', {

    scrollbar: {
      el: '.swiper-scrollbar',
      hide: true,
    },
})});
