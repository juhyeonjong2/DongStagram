$(function(){
    //팝업열기
    $('.popupshow').click(function(){
        $('.popup').fadeIn(0);
    });

    //팝업닫기
    $('.popup a').click(function(){
        $('.popup').fadeOut(0);
    });
});