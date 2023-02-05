/*****************************************************************************************************
Created By: Ferdous Md. Jannatul, Sr. Software Engineer
Created On: 10 December 2005
Last Modified: 13 April 2006
******************************************************************************************************/
		//Generating Pop-up Print Preview page
//		function getPrint(print_area,btnprint,btnback)
//		{	
//		    //Creating new page
//			var pp = window.open();
//			//Adding HTML opening tag with <HEAD> … </HEAD> portion 
//			pp.document.writeln('<HTML><HEAD><title>Print Preview</title><LINK href=Styles.css  type="text/css" rel="stylesheet">')
//			pp.document.writeln('<LINK href=css/PrintStyle.css  type="text/css" rel="stylesheet" media="print"><base target="_self"></HEAD>')
//			//Adding Body Tag
//			pp.document.writeln('<body MS_POSITIONING="GridLayout" bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">');
//			//Adding form Tag
//			pp.document.writeln('<form  method="post">');
//			//Creating two buttons Print and Close within a table
//			pp.document.writeln('<TABLE width=100%><TR><TD></TD></TR><TR><TD align=right><INPUT ID="PRINT" type="button" value="Print" onclick="javascript:location.reload(true);window.print();"><INPUT ID="CLOSE" type="button" value="Close" onclick="window.close();"></TD></TR><TR><TD></TD></TR></TABLE>');
//			//Writing print area of the calling page
//			pp.document.writeln(document.getElementById(print_area).innerHTML);
//			//Ending Tag of </form>, </body> and </HTML>
//			pp.document.writeln('</form></body></HTML>');
//			//Hidding Buttons
//			document.getElementById("<%=btnprint.ClientID%>").setAttribute('display','none');
//		    document.getElementById("<%=btnback.ClientID%>").setAttribute('display','none');			
//			
//		}
		function Clickheretoprint()
        { 
              var disp_setting="toolbar=yes,location=no,directories=yes,menubar=yes,"; 
                  disp_setting+="scrollbars=yes,width=650, height=600, left=100, top=25"; 
              var content_vlue = document.getElementById("print_content").innerHTML; 
              
              var docprint=window.open("","",disp_setting); 
               docprint.document.open(); 
               docprint.document.write('<html><head><title>Inel Power System</title>'); 
               docprint.document.write('</head><body onLoad="self.print()"><center>');          
               docprint.document.write(content_vlue);          
               docprint.document.write('</center></body></html>'); 
               docprint.document.close(); 
               docprint.focus(); 
        }

		