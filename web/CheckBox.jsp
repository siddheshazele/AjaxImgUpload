<%@page import="com.mysql.jdbc.Driver" %>
<%@page import="java.sql.*"%>
<div id="showTab"></div>
<%
            
            String query = "select * from brand";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/computershop", "root", "root");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
            out.print("<li class=\"catChkCls\"><input name=\"catChk\" type=\"checkbox\" value=\""+ rs.getString(1) +"\">&nbsp" + rs.getString(2) + "</li>");
                       }
%>
<script src="script/jquery-1.8.2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("input[name='catChk']").change(function(){  
      var allchk = "";  

    $('input:checkbox[name=catChk]').each(function() 
    {    
        if($(this).is(':checked'))
          {
              allchk+=" "+$(this).val();
          }  
    });
    $("#showTab").html(allchk);
    });
    });
</script>
