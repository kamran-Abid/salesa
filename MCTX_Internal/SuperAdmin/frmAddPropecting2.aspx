<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmAddPropecting2.aspx.cs" Inherits="MCTX_Internal_GeneralUser_frmAddPropecting" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <script src="../../js/jquery-1.4.2.min.js" type="text/javascript"></script>

    <link href="diQuery-collapsiblePanel.css" rel="stylesheet" type="text/css" />

    <script src="diQuery-collapsiblePanel.js" type="text/javascript"></script>
    <title>Prospecting</title>
   
</head>
<body>
    <form id="form1" runat="server">
        
<div class="collapsibleContainer" title="Example Collapsible Panel">
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.... (you get the idea!) </p>
     <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.... (you get the idea!) </p>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.... (you get the idea!) </p>
       <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.... (you get the idea!) </p>
</div>




    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
  $(document).ready(function() {
        $(".collapsibleContainer").collapsiblePanel();
    });

</script>