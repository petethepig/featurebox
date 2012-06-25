// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs


var FeatureBox={
  initAjaxListeners:function(){
    $(".vote-btn").bind("ajax:success",function(ev,data){
      var obj = data;
      if(obj.error){

      }else{
        $(this).parent().children(".vote-frame").children(".vote-number").text(obj.total_votes);
        $(this).parent().children(".vote-frame").children(".user-votes").text("+"+obj.user_votes).removeClass("hidden");
        $(this).parent().children(".vote-frame").children(".votes-label").text(obj.total_votes==1?"vote":"votes");
        if(obj.votes_left>0)
          $("#votes-left").children("span").text(obj.votes_left+(obj.votes_left==1?" vote":" votes"));
        else
          $("#votes-left").text("You have no votes left")
      }
    });
    $("a.disabled").click(function(e){e.preventDefault();return false});
  }
}

$(document).ready(function(){
  FeatureBox.initAjaxListeners();
});