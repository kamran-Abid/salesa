//------------------------------This Js plug-in  is used to Restrict Text fied-------------------------------------------------------


//---------------------------------------allow only Number--------------------------------------------------------------------------------------

$(document).ready(function () {
             
             $(".numberinput").forceNumeric();
              $('.characterOnly').AllowOnlyCharacters();
             $('.numberWithDot').AllowOnlyNumaberAndDot(); 
             $('.numberwithPlus').AllowOnlyNumberAndPlus();
            
         });

//---------------------------------------allow only Number--------------------------------------------------------------------------------------
       
         jQuery.fn.forceNumeric = function () {

             return this.each(function () {
                 $(this).keydown(function (e) {
                     var key = e.which || e.keyCode;

                     if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                     // numbers   
                         key >= 48 && key <= 57 ||
                     // Numeric keypad
                         key >= 96 && key <= 105 ||
                     // comma, period and minus, . on keypad
                        key == 190 || key == 188 || key == 109 || key == 110 ||
                     // Backspace and Tab and Enter
                        key == 8 || key == 9 || key == 13 ||
                     // Home and End
                        key == 35 || key == 36 ||
                     // left and right arrows
                        key == 37 || key == 39 ||
                     // Del and Ins
                        key == 46 || key == 45)
                         return true;

                     return false;
                 });
             });
         }
         
  //---------------------------------------allow  Number and dot only----------------------------------------------------------------------
 
    jQuery.fn.AllowOnlyNumaberAndDot=function ()
     {
         $(this).keypress(function(event) {
         
           if(event.keyCode==8 || event.keyCode==46 || event.keyCode==35|| event.keyCode==36|| event.keyCode==37|| event.keyCode==38|| event.keyCode==39|| event.keyCode==40)
           return true;
            if (event.which != 46 && (event.which < 47 || event.which > 59))
            {
                event.preventDefault();
                if ((event.which == 46) && ($(this).indexOf('.') != -1)) {
                    event.preventDefault();
                }
            }
        });
    }

 //---------------------------------------------------allow Characters only-------------------------------------------------------------------
 
 
  jQuery.fn.AllowOnlyCharacters=function ()
    {

    $(this).bind('keyup blur',function(){ 
    $(this).val( $(this).val().replace(/[^a-zA-Z ]/g,'') ); }
    );
    }
  //---------------------------------------allow  Number and plus only----------------------------------------------------------------------
 
 jQuery.fn.AllowOnlyNumberAndPlus=function ()
    {
        $(this).bind('keyup blur',function(){ 
        $(this).val( $(this).val().replace(/[^0-9+]/g,'') ); }
        );
    }  
  
